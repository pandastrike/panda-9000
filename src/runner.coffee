{join} = require "path"
helpers = require "./index"
{task} = helpers

source = (join process.cwd(), "tasks", "index")

{call, exist, read} = require "fairmont"

call ->
  # TODO add checks for .js or .litcoffee
  if yield exist "#{source}.coffee"
    CoffeeScript = require "coffee-script/register"
    definitions = require source
    definitions helpers
  else
    console.error "Unable to find a tasks/index.{js,coffee} file"
    process.exit -1

  tasks = process.argv[2..]

  if tasks.length == 0
    task "default"
  else
    (task name) for name in tasks

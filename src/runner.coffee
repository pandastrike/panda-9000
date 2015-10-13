{join} = require "path"
helpers = require "./index"
{task} = helpers

{call, exist, read} = require "fairmont"

tasks = process.argv[2..]
source = (join process.cwd(), "tasks", "index")

call ->
  # TODO add checks for .js or .litcoffee
  if yield exist "#{source}.coffee"
    CoffeeScript = require "coffee-script/register"
    # task = require source
    require source
    if tasks.length == 0
      task "default"
    else
      (task name) for name in tasks
  else
    console.error "Unable to find a tasks/index.{js,coffee} file"
    process.exit -1

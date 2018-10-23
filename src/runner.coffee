import "coffee-script/register"
import {join} from "path"
import {task} from "./index"
import {exist} from "panda-quill"

tasks = process.argv[2..]
source = (join process.cwd(), "tasks", "index")

do ->
  # TODO add checks for .js or .litcoffee
  if await exist "#{source}.coffee"
    # import task from source
    require source
    if tasks.length == 0
      task "default"
    else
      (task name) for name in tasks
  else
    console.error "Unable to find a tasks/index.{js,coffee} file"
    process.exit -1

import "coffeescript/register"
import {join} from "path"
import {run} from "./task"
import {exist} from "panda-quill"
import {red} from "colors/safe"

tasks = process.argv[2..]
source = (join process.cwd(), "tasks", "index")

do ->
  try
    # TODO add checks for .js or .litcoffee
    if await exist "#{source}.coffee"
      # import task from source
      require source
      if tasks.length == 0
        run "default"
      else
        # TODO: this is kind of redundant with the code
        # in runner to run dependent tasks
        (await run name) for name in tasks
    else
      console.error red "Unable to find a tasks/index.{js,coffee} file"
      process.exit -1
  catch error
    console.error red "p9k: #{error.stack}"

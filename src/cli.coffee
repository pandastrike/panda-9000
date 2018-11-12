import coffee from "coffeescript"
import {join} from "path"
import {run} from "./task"
import {isFile, read} from "panda-quill"
import {red} from "colors/safe"

tasks = process.argv[2..]
path = (join process.cwd(), "tasks", "index")

compile = (path) ->
  code = coffee.compile (await read path),
    filename: source
    bare: true
    inlineMap: true
    transpile:
      presets: [[
        resolve "@babel/preset-env"
        targets: node: "current"
      ]]
  {code, path}

load = ({code, path}) ->
  vm.runInThisContext code, filename: path

do ->
  try
    # TODO add checks for .js or .litcoffee
    if await isFile "#{source}.coffee"
      # import task from source
      load await compile path

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

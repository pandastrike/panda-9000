import vm from "vm"
import Module from "module"
import coffee from "coffeescript"
import {join} from "path"
import {run} from "./task"
import {isFile, read} from "panda-quill"
import {red} from "colors/safe"

tasks = process.argv[2..]
# TODO add checks for .js or .litcoffee
path = (join process.cwd(), "tasks", "index.coffee")

do ->
  try
    if await isFile path
      # import tasks
      coffee.run (await read path),
        filename: path
        bare: true
        inlineMap: true
        transpile:
          presets: [[
            "@babel/preset-env"
            targets: node: "current"
          ]]

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

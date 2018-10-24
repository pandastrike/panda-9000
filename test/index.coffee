import assert from "assert"
import {resolve, join} from "path"
import {print, test} from "amen"
import {define, run, create, write} from "../src"
import {go, map, tee, wait, start} from "panda-river"
import {glob, read, isDirectory, lsr, rm, rmDir} from "panda-quill"

src = resolve "test", "files"
target = resolve "test", "build"

do ->
  print await test "Panda-9000", [

    test "define task", ->

      define "clean", ->
        if await isDirectory target
          await start map rm, await lsr target
          await rmDir target

      define "poem", [ "clean" ], ->
        go [
          await glob "*.txt", src
          map create src
          wait tee (context) ->
            context.source.content = await read context.source.path
            context.target.content = context.source.content +
              "whose fleece was white as snow."
          wait tee write target
        ]

      await run "poem"

      assert.equal "Mary had a little lamb,\nwhose fleece was white as snow.",
        await read join target, "poem.txt"

  ]

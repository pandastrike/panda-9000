import assert from "assert"
import {resolve, join} from "path"
import {print, test} from "amen"
import {define, run, glob, read, write} from "../src"
import {tee} from "panda-garden"
import {go, map, wait, start} from "panda-river"
import {isDirectory, rmr, read as _read} from "panda-quill"

source = resolve "test", "files"
target = resolve "test", "build"

do ->
  print await test "Panda-9000", [

    test "define task", ->

      define "clean", -> rmr target

      define "poem", [ "clean" ], ->
        go [
          glob "*.txt", source
          wait map read
          map tee (context) ->
            context.target.content = context.source.content +
              "whose fleece was white as snow."
          wait map write target
        ]

      await run "poem"

      assert.equal "Mary had a little lamb,\nwhose fleece was white as snow.",
        await _read join target, "poem.txt"

  ]

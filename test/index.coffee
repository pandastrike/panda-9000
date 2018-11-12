import assert from "assert"
import {resolve, join} from "path"
import {print, test} from "amen"
import {define, run, create, read, write} from "../src"
import {tee} from "panda-garden"
import {go, map, wait, start} from "panda-river"
import {glob, isDirectory, lsr, rm, rmDir, read as _read} from "panda-quill"

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
          wait map read
          map tee (context) ->
            context.target.content = context.source.content +
              "whose fleece was white as snow."
          wait map write target
        ]

      await run "poem"

      assert.equal "Mary had a little lamb,\nwhose fleece was white as snow.",
        await _read join target, "poem.txt"

      await run "poem&"

      assert.equal "Mary had a little lamb,\nwhose fleece was white as snow.",
        await _read join target, "poem.txt"

  ]

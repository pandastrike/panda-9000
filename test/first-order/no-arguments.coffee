{join} = require "path"
assert = require "assert"

{run, define, context, jade, coffee, stylus, write} = require "../../src"
{async, go, map, tee, glob, sleep, all, readdir, deepEqual} = require "fairmont"

{clean} = require "../helpers"

src = join "test", "files"
target = join "test", "build"

# Tasks are not functions, so we can't wait for them to return / resolve, but
# we can work around that with polling.
status = [false, false, false]
check = async ->
  while true
    return if all ((n) -> n == true), status
    yield sleep 100

module.exports = async ->
  yield clean()

  define "jade", async ->
    yield go [
      glob "*.jade", src
      map context src
      tee jade
      tee write target
    ]
    status[0] = true

  run "jade"

  define "coffee", async ->
    yield go [
      glob "*.coffee", src
      map context src
      tee coffee
      tee write target
    ]
    status[1] = true

  run "coffee"

  define "stylus", async ->
    yield go [
      glob "*.styl", src
      map context src
      tee stylus
      tee write target
    ]
    status[2] = true

  run "stylus"

  yield check()

  assert deepEqual((yield readdir target),
    [
      "hello-world.coffee"
      "hello-world.jade"
      "hello.styl"
    ]
  )

  yield clean()

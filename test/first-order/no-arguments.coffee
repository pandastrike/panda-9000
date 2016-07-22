{join} = require "path"
assert = require "assert"

{run, define, context, jade, coffee, stylus, write, sass, handlebars} = require "../../src"
{async, go, map, tee, glob, sleep, all, readdir, deepEqual} = require "fairmont"

{clean} = require "../helpers"

src = join "test", "files"
target = join "test", "build"

# Tasks are not functions, so we can't wait for them to return / resolve, but
# we can work around that with polling.
status = [false, false, false, false, false]
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

  define "sass", async ->
    yield go [
      glob "*.scss", src
      map context src
      tee sass
      tee write target
    ]
    status[3] = true

  run "sass"

  define "handlebars", async ->
    yield go [
      glob "*.hb", src
      map context src
      tee handlebars
      tee write target
    ]
    status[4] = true

  run "handlebars"

  yield check()

  subject = (yield readdir target)
  expected = [
    "hello-world.coffee"
    "hello-world.hb"
    "hello-world.jade"
    "hello.scss"
    "hello.styl"
  ]
  assert deepEqual(subject, expected), "expected #{expected}, got #{subject}"

  yield clean()

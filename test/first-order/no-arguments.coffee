{join} = require "path"
assert = require "assert"

{run, define, context, pug, coffee, stylus, write, handlebars} = require "../../src"
pug = pug()
{async, go, map, tee, glob, sleep, all, readdir, deepEqual} = require "fairmont"

{clean} = require "../helpers"

src = join "test", "files"
target = join "test", "build"

# Tasks are not functions, so we can't wait for them to return / resolve, but
# we can work around that with polling.
status = [false, false, false, false]
check = async ->
  while true
    return if all ((n) -> n == true), status
    yield sleep 100

module.exports = async ->
  yield clean()

  define "pug", async ->
    yield go [
      glob "*.+(pug|jade)", src
      map context src
      tee pug
      tee write target
    ]
    status[0] = true

  run "pug"

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

  define "handlebars", async ->
    yield go [
      glob "*.hb", src
      map context src
      tee handlebars
      tee write target
    ]
    status[3] = true

  run "handlebars"

  yield check()

  subject = (yield readdir target)
  expected = [
    "hello-world.coffee"
    "hello-world.hb"
    "hello-world.jade"
    "hello.styl"
  ]
  assert deepEqual(subject, expected), "expected #{expected}, got #{subject}"

  yield clean()

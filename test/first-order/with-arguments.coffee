assert = require "assert"

{run, define} = require "../../src"
{async, sleep, all, include} = require "fairmont"

# Tasks are not functions, so we can't wait for them to return / resolve, but
# we can work around that with polling.
status = [false]
check = async ->
  while true
    return if all ((n) -> n == true), status
    yield sleep 100

module.exports = async ->
  file = ""
  define "name",  (name, extension) ->
    file = name + extension
    status[0] = true

  run "name", ["foo", ".html"]

  yield check()
  assert.equal file, "foo.html"

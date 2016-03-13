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
  string = ""
  define "rhyme1", ->
    string += "Mary had a little lamb "
  define "rhyme2", ->
    string += "whose fleece was white as snow. "
  define "rhyme3", ->
    string += "And everywhere Mary went "

  define "rhyme", ["rhyme1", "rhyme2", "rhyme3"], ->
    string += "the lamb was sure to go."
    status[0] = true

  run "rhyme"

  yield check()
  poem = "Mary had a little lamb whose fleece was white as snow. " +
    "And everywhere Mary went the lamb was sure to go."
  assert.equal string, poem

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
  define "madlib1", (name, noun) ->
    string += "#{name} had a little #{noun} "
  define "madlib2", (color) ->
    string += "whose fleece was #{color} as snow. "
  define "madlib3", ->
    string += "And everywhere Mary went "

  config = [
    { name: "madlib1", arguments: ["Mary", "lamb"]}
    { name: "madlib2", arguments: ["white"]}
    "madlib3"
  ]
  define "madlib", config, (verb) ->
    string += "the lamb was sure to #{verb}."
    status[0] = true

  run "madlib", ["go"]

  yield check()
  poem = "Mary had a little lamb whose fleece was white as snow. " +
    "And everywhere Mary went the lamb was sure to go."
  assert.equal string, poem

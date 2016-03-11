{task, context, jade, coffee, stylus, write} = require "../src"
{go, map, tee, glob} = require "fairmont"

task "jade", ->
  go [
    glob "*.jade", "test/files"
    map context "test/files"
    tee jade
    tee write "test/build"
  ]

task "jade"

task "coffee", ->
  go [
    glob "*.coffee", "test/files"
    map context "test/files"
    tee coffee
    tee write "test/build"
  ]

task "coffee"

# Tasks can also accept arugment(s) passed in as an array.
task "coffee-name", (name, action) ->
  console.log "\n====================="
  console.log "Hello, #{name}. #{action}"
  console.log "=====================\n"

task "coffee-name", ["World", "It's time to show what we can do."]

task "stylus", ->
  go [
    glob "*.styl", "test/files"
    map context "test/files"
    tee stylus
    tee write "test/build"
  ]

task "stylus"

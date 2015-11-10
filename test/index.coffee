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

task "stylus", ->
  go [
    glob "*.styl", "test/files"
    map context "test/files"
    tee stylus
    tee write "test/build"
  ]

task "stylus"

{call, next} = require "fairmont"
{glob} = require "../src/helpers"

call ->
  paths = glob "*.coffee", "src"
  console.log yield next paths

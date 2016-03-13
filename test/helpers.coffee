{join} = require "path"
{unlinkSync} = require "fs"
{async, go, map, lsr, rm, exists} = require "fairmont"

target = join __dirname, "build"

clean = async ->
  # Create the target directory if it doesn't exist.
  if !(yield exists target)
    yield mkdir "0777", target
    return

  # Clean out the target directory if it does exist.
  yield go [
    lsr join __dirname, "build"
    map rm
  ]

module.exports = {clean}

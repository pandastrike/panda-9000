{join, basename} = require "path"
{glob, read, write, partial, _, isPromise,
  async, curry, map, start, flow, events,
  throttle} = require "fairmont"
jade = require "jade"
coffee = require "coffee-script"
stylus = require "stylus"
fs = require "fs"
{promise} = require "when"

glob = partial glob, _, "./"

compileJade = (path) ->
  filename = basename path, ".jade"
  [filename, (do jade.compileFile path)]

compileStylus = (plugins...) ->
  async (path) ->
    filename = basename path, ".styl"
    source = yield read path
    css = yield promise (resolve, reject) ->
      stylus.render source,
        filename: path
        use: plugins
        (error, css) ->
          unless error? then resolve css else reject error
    [filename, css]

compileCoffeeScript = async (path) ->
  filename = basename path, ".coffee"
  [filename, (coffee.compile (yield read path))]

writeFile = (directory, extension) ->
  async (x) ->
    if isPromise x
      x = yield x
    [filename, content] = x
    yield write (join directory, "#{filename}#{extension}"), content

watchFile = curry (f, path) ->

  console.log "Watching file [#{path}] for changes..."

  start flow [
    events "change", fs.watch path
    throttle 5000
    map ->
      console.log "Change detected for file [#{path}]..."
      f()
    ]

module.exports = {glob, compileJade, compileStylus, compileCoffeeScript,
  writeFile, watchFile}

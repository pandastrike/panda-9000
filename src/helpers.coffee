{dirname, join, basename} = require "path"
{glob, read, write, partial, _, isPromise,
  async, curry, map, start, flow, go, events,
  throttle, mkdirp, md5} = require "fairmont"
jade = require "jade"
coffee = require "coffee-script"
stylus = require "stylus"
fs = require "fs"
{promise} = require "when"

glob = partial glob, _, "./"

compileJade = (context) ->
  {path, locals} = context
  render = jade.compileFile path, cache: false
  context.output = render locals

compileStylus = async (context) ->
  source = yield read context.path
  context.output = yield promise (resolve, reject) ->
    stylus.render source,
      filename: context.path
      (error, css) -> unless error? then resolve css else reject error

compileCoffeeScript = async (context) ->
  context.output = coffee.compile yield read context.path

writeFile = (directory, extension) ->
  async ({rpath, output}) ->
    path = join directory, rpath.replace /\.\w+$/, extension
    yield mkdirp "0777", (dirname path)
    yield write path, output

watchFile = curry (f, path) ->

  console.log "Watching file [#{path}] for changes..."

  go [
    events "change", fs.watch path
    throttle 5000
    map ->
      console.log "Change detected for file [#{path}]..."
      f path
    ]

#
# task "bundle", "code", async ->
#   b = browserify()
#   yield start flow [
#     yield glob "lib/*.js"
#     map (path) -> b.add path
#   ]
#   b.bundle().pipe createWriteStream join "build", "app.js"
#

module.exports = {glob, compileJade, compileStylus, compileCoffeeScript,
  writeFile, watchFile}

{dirname, join, basename} = require "path"
{glob, read, write, partial, _, isPromise,
  async, curry, map, start, flow, go, events,
  throttle, mkdirp, md5, include} = require "fairmont"
jade = require "jade"
coffee = require "coffee-script"
stylus = require "stylus"
fs = require "fs"
{promise} = require "when"

glob = partial glob, _, "./"

compileJade = (context) ->
  {source, data} = context
  render = jade.compileFile source.path, cache: false
  output = render data
  include {output}, context

compileStylus = async (context) ->
  {source} = context
  code = yield read source.path
  output = yield promise (resolve, reject) ->
    stylus.render code,
      filename: source.path
      (error, css) -> unless error? then resolve css else reject error
  include {output}, context

compileCoffeeScript = async (context) ->
  {source} = context
  output = coffee.compile yield read source.path
  include {output}, context

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

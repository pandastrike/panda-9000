{read} = require "fairmont"
{parse} = require "c50n"
{resolve,join,extname} = require "path"
glob = require "panda-glob"
{log,sh} = require "../operators"

buildPath = resolve("build/web")
envPath = resolve("env")

module.exports = 
  publish: (name) ->
    config = parse(read(join(envPath,"#{name}/config.cson")))
    {bucket} = config.publish.s3
    for path in glob(buildPath, "**/*")
      do (path) ->
        fullPath = join(buildPath, path)
        log "Updating [#{path}] ..."
        if extname(path) == ""
          sh "s3cmd -m 'text/html' put #{fullPath} s3://#{bucket}/#{path}"
        else
          sh "s3cmd put #{fullPath} s3://#{bucket}/#{path}"

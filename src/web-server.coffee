connect = require("connect")
FileSystem = require "fs"
{resolve,join} = require "path"
async = require "async"

isFile = (path, callback) ->
  FileSystem.stat path, (error,stats) ->
    unless error?
      if stats.isFile( path )
        callback(true)
      else
        callback(false)
    else
      callback(false)
      
Ax = require "ax"
log = new Ax level: "info", stream: process.stdout

webPath = (resolve "build", "web")

logger = (request,response,next) ->
  end = response.end
  response.end = (args...) ->
    end.apply response, args
    log.info "#{response.statusCode} #{request.method} #{request.url}"
  next()

streamResponse = (response,path) ->
  stream = FileSystem.createReadStream( path )
  stream.pipe( response )
  stream.on "error", (error) ->
    log.error "Error: unable to stream response from #{path}"
    log.error if error.stack? then error.stack else error.message
    response.statusCode = 500
    response.end()
  
  
class Server

  constructor: (options) ->
    {@port,@host} = options.web
        
  run: ->
    
    @app = connect()

    @app.use logger
    @app.use connect.compress()
    @app.use (request,response,next) ->
      accept = request.headers["accept"]
      unless ( request.method == "GET" ) and accept.match( /text\/html/ )
        next()
      else
        path = join(webPath, request.url[1..])
        async.detect [
          path
          join(path, "index.html")
          ], isFile, (path) ->
            unless path?
              next()
            else
              response.setHeader("content-type","text/html")
              streamResponse(response, path)
    @app.use connect.static( webPath )    
    @app.listen(@port,@host)

    console.log("HTTP server listening on port #{@port} and IP #{@host}")

Server.run = (options) -> (new Server(options).run())

module.exports = Server


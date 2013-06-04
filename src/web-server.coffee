connect = require("connect")
FileSystem = require "fs"
{resolve} = require "path"
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

webPath = (resolve __dirname, "..", "build", "web")

logger = (request,response,next) ->
  end = response.end
  response.end = (args...) ->
    end.apply response, args
    log.info "#{response.statusCode} #{request.method} #{request.url}"
  next()

class Server

  constructor: (options) ->
    {@port,@host} = options.web
        
  run: ->
    
    @app = connect()

    @app.use logger
    @app.use connect.compress()
    @app.use connect.static( webPath )
    
    # Attempt to locate HTML files that correspond to GET requests
    # for HTML or */* ... ex: /foo/bar to build/foo/bar.html
    @app.use (request,response,next) ->
      accept = request.headers["accept"]
      if ( request.method == "GET" ) and 
      ( accept.match( /html/ ) or accept == "*/*" )
        path = resolve( webPath, request.url[1..] )
        async.detect [
          resolve( path, "index.html" )
          "#{path}.html"
          ], isFile, (path) ->
            # If we found a file, then stream it in the response;
            # otherwise, just return /index.html and let the client-side
            # app figure out what to do with the path
            if path? and ( stream = FileSystem.createReadStream( path ) )?
              stream.pipe( response )
              response.setHeader("content-type","text/html")
            else
              path = resolve( webPath, "index.html" )
              stream = FileSystem.createReadStream( path )
              if stream?
                stream.pipe( response )
                response.setHeader("content-type","text/html")
              else
                log.error "Unable to read from /index.html"
              
      else
        next()
    
    @app.listen(@port,@host)

    console.log("HTTP server listening on port #{@port} and IP #{@host}")

Server.run = (options) -> (new Server(options).run())

module.exports = Server


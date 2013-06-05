{resolve} = require "path"
{EventChannel} = require "mutual"
Patchboard = require("patchboard")

events = new EventChannel
events.on error: (error) -> console.error error

api =
  paths: require( resolve( "src/api/paths.coffee" ) )
  resources: require( resolve( "src/api/resources.coffee" ) )
  schema: require( resolve( "src/api/schema.coffee" ) )

Handlers = require( resolve( "src/api/handlers.coffee" ) )

module.exports = class Server
  
  @run: (options) -> 
    ( new @ options ).run()

  constructor: (@options) ->

  run: ->
    
    do events.serially (go) =>
      
      go => Handlers.create( @options )
      
      go (handlers) => 
        {url} = @options.web
        {host,port} = @options.api
        server = new Patchboard.Server api, 
          url: url
          host: host
          port: port
          handlers: handlers
          validate: true
    
        server.run()        

{EventChannel} = require "mutual"
Patchboard = require("patchboard")
Handlers = require("./api/handlers")

api =
  paths: require("./api/paths.coffee")
  resources: require("./api/resources.coffee")
  schema: require("./api/schema.coffee")

events = new EventChannel
events.on error: (error) -> console.error error

module.exports = class Server
  
  @run: (options) -> 
    ( new @ options ).run()

  constructor: (options) ->
    {@host,@port} = options.api
    {@url} = options.web.api

  run: ->
    
    _events = Handlers.create( events: events )

    _events.on "success", (handlers) => 
    
      server = new Patchboard.Server api, 
        url: @url
        host: @host
        port: @port
        handlers: handlers
        validate: true
    
      server.run()        
      # console.log "Service URL is: #{@url}"

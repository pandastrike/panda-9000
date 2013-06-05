{resolve} = require "path"
{exists,rmdir,chdir} = require "fairmont"
system = require "node-system"

module.exports = $ = {}

$.directory = do ->
  mkdir = (path) ->
    $.sh "mkdir -p #{path}"

  (path,action=mkdir) ->
    path = resolve( path )
    action( path ) unless exists( path )

$.file = (path,action) ->
  path = resolve( path )
  action( path ) unless exists( path )

$.chdir = (path,action) ->
  path = resolve( path )
  $.log "Changing directory to [#{path}]"
  chdir( path, action )
  
$.sh = do ->
  log = (output) ->
    if output? && output != ""
      $.log( output )
    else 
      $.log( "Done" )
  (command,action=log) ->
    $.log( command )
    action( system( command ) )

$.shLocal = (command,action) ->
  [script,args...] = command.split(/\s/)
  command = [ resolve( __dirname, "..", script ), args...].join(" ")
  $.sh( command, action )

$.rmdir = (path) ->
  path = resolve( path )
  rmdir( path ) if exists( path )
  
$.log = (string) ->
  process.stdout.write( string + "\n" )
  
$.abort = (string) ->
  process.stderr.write( string + "\n" ) if string?
  process.exit(-1)
  
$.run = -> do task for task in arguments

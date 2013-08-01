{resolve} = require "path"
{exists,rmdir,chdir,type,stat} = require "fairmont"
system = require "node-system"

module.exports = $ = {}  

$.mkdirp = (path) ->
  $.sh "mkdir -p #{path}"

$.directory = (path,action=$.mkdirp) ->
  path = resolve( path )
  action( path ) unless exists( path )

$.file = (path,action) ->
  path = resolve( path )
  action( path ) unless exists( path )

$.mtime = do ->

  {max} = Math
  hoist = (value) -> if type(value) != "array" then [ value ] else value
  _mtime = (paths) -> 
    paths = hoist( paths )
    mtimes = for path in paths
      if exists( path ) then stat( path ).mtime.getTime() else -1
    max( mtimes... )

  (sources,destination,fn) ->
    fn() if _mtime( sources ) > _mtime( destination )


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

$.local = (script) ->
  resolve( __dirname, "..", script )

$.rmrf = (path) ->
  path = resolve( path )
  if exists( path )
    $.sh("rm -rf #{path}")
  
$.log = (string) ->
  process.stdout.write( string + "\n" )
  
$.abort = (string) ->
  process.stderr.write( string + "\n" ) if string?
  process.exit(-1)
  
$.run = -> do task for task in arguments

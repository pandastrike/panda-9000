system = require "node-system"
{read,readdir,write,exists,stat} = require "fairmont"
{resolve,dirname,extname} = require "path"
{log,mtime,directory} = require "../operators"
buildRoot = resolve("build/web")
cssRoot = resolve("src/web/css")

module.exports =
  
  css: ->
    log "Building CSS files"
    
    directory buildRoot

    for file in readdir( cssRoot )
      source = resolve( cssRoot, file )
      destination = resolve( buildRoot, "css", file.replace(/coffee$/,"css") )
      mtime source, destination, ->
        switch extname( file )
          when ".coffee"
              console.log "Generating CSS from #{file}"
              Renderer = require( source )
              write( destination, Renderer.main() )
          when ".css"
            console.log "Copying CSS from #{file}"
            system "cp #{source} #{destination}"

{log,sh,directory} = require "../operators"

module.exports =
  sync: ->
    log "Synchronizing source and build directories"
    directory "build/web"
    directory "build/ark"
    sh "rsync -avv src/web/ark/ build/ark/", -> log( "Done" )
    sh "rsync -avv src/web/assets/ build/web", -> log( "Done" )
    
  config: (name) ->
    log "Bundling configuration"
    sh "rsync -avv env/#{name}/config.cson build/ark/", -> log( "Done" )

    
  
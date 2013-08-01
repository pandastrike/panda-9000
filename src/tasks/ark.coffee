{log,file,chdir,sh,directory} = require "../operators"

module.exports = 
  npm: ->
    log "Installing Node modules for Ark"
    file "src/web/ark/node_modules", ->
      chdir "src/web/ark", ->
        sh "npm install"
  
  ark: ->
    log "Building the ark"
    directory "node_modules/ark", ->
      log "Installing ark"
      sh "npm install ark --save-dev"
    ark = "node_modules/ark/bin/ark"
    manifest = "build/ark/ark.cson"
    file manifest, ->
      abort "Missing ark manifest"
    file "build/ark/package.json", ->
      abort "Missing ark package.json"
    js = "build/web/js/application.js"
    directory "build/web/js"
    sh "#{ark} package -v -t -m #{manifest} -f #{js}"
  
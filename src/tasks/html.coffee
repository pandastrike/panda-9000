system = require "node-system"
{type,read,write,exists,stat} = require "fairmont"
{resolve,join,dirname} = require "path"
CSON = require "c50n"
{log,mtime,directory} = require "../operators"
buildRoot = resolve("build/web")
arkPath = resolve( "src/web/ark" )
pagesPath = join(arkPath,"html/pages.cson")
framePath = join(arkPath, "html/frame.coffee")
Frame = null

loadGadget = (name) ->
  require join(arkPath, "gadgets/#{name}")

builders = 
  file: (name,page) ->
    filename = if page.ext? then "#{name}.#{page.ext}" else name
    _directory = if page.directory? then page.directory else "."
    path = resolve(buildRoot, _directory, filename)
    directory dirname(path)
    name = if page.key? then page.key else name
    frame = new Frame
    render = -> 
      write path, frame.main()
    if page.subtype?
      Gadget = loadGadget(page.subtype)
      gadget = new Gadget({name})
      frame.feature = -> 
        @div class: "feature", => @text gadget.render()
      if gadget.load?
        gadget.load().on "success", render
      else
        render()
    else
      render()
      
  directory: (name,page) ->
    directory name
    Gadget = loadGadget(page.subtype)
    for key in Gadget.match(page.match)
      builders.file key,
        type: "file"
        ext: page.ext
        directory: name
        subtype: page.subtype
  
module.exports = 
  html: ->
    log "Building static Web pages"
    Frame ?= require(framePath)
    directory buildRoot
    for name,page of CSON.parse( read( pagesPath ) )
      builders[page.type](name, page)
import {parse as _parse, relative, join} from  "path"
import {curry, binary} from "panda-garden"
import {promise, include} from "panda-parchment"
import {flow, map} from "panda-river"
import {glob, read, write as _write, mkdirp} from "panda-quill"
import _pug from "pug"
import _coffee from "coffeescript"
import _stylus from "stylus"
import _template from "panda-template"

parse = (path) ->
  {dir, name, ext} = _parse path
  path: path
  directory: dir
  name: name
  extension: ext

context = curry (_directory, _path) ->
  {path, directory, name, extension} = parse _path
  path: relative _directory, (join directory, name)
  name: name
  source: {path, directory, name, extension}
  target: {}
  data: {}

# options exposes the Pug API's compile options.
pug = (options={}) ->
  ({source, target, data}) ->
    source.content ?= await read source.path
    options.filename = source.path
    render = _pug.compile source.content, options
    target.content = render data

handlebars = ({source, target, data}) ->
  source.content ?= await read source.path
  target.content = _handlebars source.content, data

stylus = ({source, target}) ->
  source.content ?= await read source.path
  target.content = await promise (resolve, reject) ->
    _stylus.render source.content, filename: source.path,
      (error, css) -> unless error? then resolve css else reject error

coffee = ({source, target}) ->
  source.content ?= await read source.path
  target.content = _coffee.compile source.content

write = curry binary (directory, {path, target, source}) ->
  if target.content?
    if !target.path?
      extension = if target.extension?
        target.extension
      else if source.extension?
        source.extension
      else ""
      include target,
        parse (join directory, "#{path}#{extension}")
    await mkdirp "0777", (target.directory)
    await _write target.path, target.content

module.exports = {context, pug, stylus, coffee, write, handlebars}

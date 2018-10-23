import {parse as _parse, relative, join} from  "path"
import {curry, binary} from "panda-garden"
import {promise, include} from "panda-parchment"
import {flow, map} from "panda-river"
import {glob, read, write as _write, mkdirp} from "panda-quill"

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

module.exports = {context, write}

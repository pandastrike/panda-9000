import {parse as _parse, relative, join} from  "path"
import {curry} from "panda-garden"
import {include} from "panda-parchment"
import {glob, read as _read, write as _write, mkdirp} from "panda-quill"

parse = (path) ->
  {dir, name, ext} = _parse path
  path: path
  directory: dir
  name: name
  extension: ext

create = curry (_directory, _path) ->
  {path, directory, name, extension} = parse _path
  path: relative _directory, (join directory, name)
  name: name
  source: {path, directory, name, extension}
  target: {}
  data: {}

read = ({path, source, target}) ->
  source.content = await _read path

write = curry (directory, {path, target, source}) ->
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
    _write target.path, target.content

export {create, read, write}

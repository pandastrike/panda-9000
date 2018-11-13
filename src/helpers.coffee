import {parse as _parse, relative, join} from  "path"
import _transform from "jstransformer"
import {curry, binary, tee} from "panda-garden"
import {include} from "panda-parchment"
import {glob, read as _read, write as _write, mkdirp} from "panda-quill"
import chokidar from "chokidar"

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

read = tee ({source}) ->
  source.content = await _read source.path

write = curry binary tee (directory, {path, target, source}) ->
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

extension = (extension) -> tee ({target}) -> target.extension = extension

copy = tee ({source, target}) -> cp source.path, target.path

transform = (transformer, options) ->
  adapter = _transform transformer
  tee ({source, target}) ->
    source.content ?= await read source.path
    options.filename = source.path
    target.content = adapter.render source.content, options

watch = (path, tasks) ->
  ->
    chokidar.watch path
    .on "all", -> run task for task in tasks

export {create, read, write, extension, copy, transform, watch}

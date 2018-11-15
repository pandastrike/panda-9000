import {parse as _parse, join, resolve} from  "path"
import _transform from "jstransformer"
import {map} from "panda-river"
import {curry, binary, tee} from "panda-garden"
import {include} from "panda-parchment"
import {read as _read, write as _write, mkdirp, cp} from "panda-quill"
import chokidar from "chokidar"

import http from "http"
import connect from "connect"
import logger from "morgan"
import finish from "finalhandler"
import rewrite from "connect-history-api-fallback"

import files from "serve-static"
import {green, red} from "colors/safe"
import _glob from "fast-glob"

parse = (path) ->
  {dir, name, ext} = _parse path
  path: path
  directory: dir
  name: name
  extension: ext

create = curry (path, rpath) ->
  include (parse rpath),
    source: parse resolve path, rpath
    target: {}
    data: {}

glob = (pattern, path) ->
  map (create path), (await _glob pattern, cwd: path)

complete = (directory, context) ->
  {target} = context
  if target.path?
    context.target = parse target.path
  else
    defaults = parse resolve directory, context.path
    target.directory ?= defaults.directory
    target.name ?= defaults.name
    target.extension ?= defaults.extension
    {directory, name, extension} = target
    target.path = join directory, "#{name}#{extension}"
  context

read = tee ({source}) ->
  source.content = await _read source.path

write = curry binary (directory, context) ->
  {target} = context
  if target.content?
    complete directory, context
    await mkdirp "0777", target.directory
    await _write target.path, target.content
    context
  else
    console.error red "[warning] p9k/write: attempt to write with no content."

extension = (extension) -> tee ({target}) -> target.extension = extension

copy = curry binary (directory, context) ->
  {source, target} = complete directory, context
  await mkdirp "0777", target.directory
  cp source.path, target.path
  context

transform = (transformer, options) ->
  adapter = _transform transformer
  tee ({source, target}) ->
    source.content ?= await read source.path
    options.filename = source.path
    result = await adapter.renderAsync source.content, options
    target.content = result.body ? ""

watch = (path, handler) ->
  ->
    chokidar.watch path, ignoreInitial: true
    .on "all", handler

serve = (path, options) ->
  ->
    {port} = options
    handler = connect()
    if options.logger?
      handler.use logger options.logger
    if options.rewrite?
      handler.use if options.rewrite then rewrite() else rewrite options.rewrite
    handler.use files "./build", options.files
    handler.use finish
    http.createServer handler
    .listen port, ->
      console.log green "p9k: server listening on port #{port}"

export {glob, read, write, extension, copy, transform, watch, serve}

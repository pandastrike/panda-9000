{curry, binary,
go, map, all, pull,
cat, async, includes,
isString, isArray, isFunction, isDefined,
Method} = require "fairmont"

_tasks = {}

_define = (qname, dependencies, f) ->
  [ancestors..., name] = qname.split "/"
  if ancestors.length > 0
    _qname = ancestors.join "/"
    try
      (lookup _qname).dependencies.push qname
    catch
      define _qname, qname
  if _tasks[qname]?
    if _tasks[qname].f?
      console.warn "Overwriting task '#{qname}', which was already defined."
    dependencies = cat _tasks[qname].dependencies, dependencies
  _tasks[qname] = {dependencies, f}

define = Method.create()

isDependencyList = (dependencies...) ->
  all isString, dependencies

isDefinition = (dependencies..., f) ->
  (isDependencyList dependencies...) &&
    (!f? || (isFunction f))

Method.define define, isString, isDependencyList,
  (name, dependencies...) -> _define name, dependencies

Method.define define, isString, isDefinition,
  (name, dependencies..., f) -> _define name, dependencies, f

lookup = Method.create()

Method.define lookup, isString,
  (name) ->
    if (task = _tasks[name])?
      task
    else
      throw new Error "Task '#{name}' is undefined"

run = Method.create()

Method.define run, isArray, isString, async (ran, name) ->
  unless includes name, ran
    start = Date.now()
    console.log "Beginning task '#{name}'..."
    ran.push name
    {dependencies, f} = lookup name
    yield go [
      dependencies
      map run ran
      pull
    ]
    yield f() if f?
    finish = Date.now()
    console.log "Task '#{name}' completed in #{finish - start}ms."

run = curry binary run

task = Method.create()

Method.define task, -> task "default"

Method.define task, isString, (name) -> run [], name

Method.define task, isString, (-> true),
  (name, definition...) -> define name, definition...

module.exports = {task}

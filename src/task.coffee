{curry, binary,
go, map, all, pull,
async, includes,
isString, isArray, isFunction, isDefined,
Method} = require "fairmont"

_tasks = {}

define = Method.create()

isDependencyList = (dependencies...) ->
  all isString, dependencies

isDefinition = (dependencies..., f) ->
  (isDependencyList dependencies...) &&
    (!f? || (isFunction f))

Method.define define, isString, isDependencyList,
  (name, dependencies...) -> _tasks[name] = {dependencies}

Method.define define, isString, isDefinition,
  (name, dependencies..., f) -> _tasks[name] = {dependencies, f}

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
    console.log "Beginning task '#{name}'..."
    ran.push name
    {dependencies, f} = lookup name
    yield go [
      dependencies
      map run ran
      pull
    ]
    yield f() if f?
    console.log "Task '#{name}' completed."

run = curry binary run

task = Method.create()

Method.define task, -> task "default"

Method.define task, isString, (name) -> run [], name

Method.define task, isString, (-> true),
  (name, definition...) -> define name, definition...

module.exports = {task}

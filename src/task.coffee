{call,
go, map, all, pull,
cat, async, includes, empty,
isString, isArray, isFunction, isDefined, isObject
Method} = require "fairmont"

# Maintain up a lookup table of all tasks.
_tasks = {}

# Allows you to lookup previously stored tasks in the lookup table.
lookup = Method.create()

Method.define lookup, isString,
  (name) ->
    if (task = _tasks[name])?
      task
    else
      throw new Error "Task '#{name}' is undefined"

# When running higher order tasks, we need read and use arugments that should
# be passed to the "dependencies", the tasks that get run beforehand.  When
# defining a task, you can pass an array of dependencies.  These may either be
# strings (no arugments), or an object with the fields "name" and "arugments".
# This helper coerces any strings into objects.
format = (deps) ->
  out = []
  try
    for dep in deps
      if isString dep
        out.push {name: dep, args: []}
      else if (isObject dep) && (isString dep.name) && (isArray dep.arguments)
        out.push {name: dep.name, args: dep.arguments}
      else
        throw new Error()
    return out
  catch e
    throw new Error "Task dependency declaration is malformed."

# When passing dependencies as an ancestor string, we need to transform those
# into proper dependency objects.  This helper formats for us.
formatRaw = (dep) ->
  if isString dep
    {name: dep, args: []}
  else
    throw new Error "Task dependency ancestor is malformed."

# define() is how the user can add tasks to the lookup table. All branches of
# that exposed multimethod feed into this helper.
_define = (qname, dependencies, f) ->
  dependencies = format dependencies
  [ancestors..., name] = qname.split "/"
  if ancestors.length > 0
    _qname = ancestors.join "/"
    try
      (lookup _qname).dependencies.push formatRaw qname
    catch
      define _qname, [qname]
  if _tasks[qname]?
    if _tasks[qname].f?
      console.warn "Overwriting task '#{qname}', which was already defined."
    dependencies = cat _tasks[qname].dependencies, dependencies
  _tasks[qname] = {dependencies, f}


# run() is how the user can invoke task from the lookup table.  All branches of
# that exposed multimethod feed into this helper.
_run = async (ran, name, args) ->
  unless includes name, ran
    # start = Date.now()
    # console.log "Beginning task '#{name}'..."
    ran.push name
    {dependencies, f} = lookup name
    yield go [
      dependencies
      map (dep) -> _run ran, dep.name, dep.args
      pull
    ]

    if f?
      if empty args
        yield f()
      else
        yield f args...


# This multimethod is exposed to allow users to add tasks to lookup table.
define = Method.create()
# Task definition that includes only a single function to run. (standard)
Method.define define, isString, isFunction,
  (name, f) -> _define name, [], f
# Task defintion that uses only previous tasks chained together.
Method.define define, isString, isArray,
  (name, dependencies) -> _define name, dependencies
# Task defintion that includes both previous tasks and a new function.
Method.define define, isString, isArray, isFunction,
  (name, dependencies, f) -> _define name, dependencies, f

# This multimethod is exposed to allow users to invoke tasks from lookup table.
run = Method.create()
# Task invocation default
Method.define run, -> run "default"
# Task invocation without arguments
Method.define run, isString, (name) -> _run [], name, []
# Task invocation with arguments
Method.define run, isString, isArray, (name, args) -> _run [], name, args

module.exports = {define, run}

import {call, cat, includes, empty, isString,
  isArray, isFunction, isDefined, isObject,
  benchmark} from "panda-parchment"
import {Method} from "panda-generics"

tasks = {}
lookup = (name) -> tasks[name]

define = Method.create
  description: "Define a task."

Method.define define, isString, isArray, isFunction,
  (name, dependencies, action) ->
    tasks[name] = {dependencies, action}

Method.define define, isString, isFunction, (name, action) ->
  define name, [], action

run = (name = "default", visited = []) ->
  unless name in visited
    console.error "p9k: Starting #{name} ..."
    visited.push name
    if (task = lookup name)?
      {dependencies, action} = task
      (await run dependency, visited) for dependency in dependencies
      duration = Math.round (await benchmark -> await action())/1000
      console.error "p9k: Finished #{name} in #{duration}ms."
    else
      console.error "p9k: task #{name} not found."

export {define, run}

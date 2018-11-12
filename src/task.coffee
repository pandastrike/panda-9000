import {call, cat, includes, empty, isString,
  isArray, isFunction, isDefined, isObject,
  microseconds} from "panda-parchment"
import {Method} from "panda-generics"
import {red, green, magenta} from "colors/safe"

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

  flag = name[-1..]
  if flag == "&"
    background = true
    name = name[0..-2]

  unless name in visited

    console.error "p9k: Starting #{green name} ..."

    visited.push name

    if (task = lookup name)?
      {dependencies, action} = task

      for dependency in dependencies
        await run dependency, visited

      start = microseconds()

      finish = ->
        finish = microseconds()
        duration = Math.round (finish - start)/1000
        console.error "p9k: Finished #{green name} in #{magenta duration}ms."

      result = action()

      if background
        if result?.then?
          result.then finish
        else
          finish()
      else
        await result
        finish()

    else
      console.error red "p9k: task #{green name} not found."

export {define, run}

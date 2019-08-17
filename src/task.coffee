import {call, cat, includes, empty, isString,
  isArray, isFunction, isDefined, isObject,
  microseconds} from "panda-parchment"
import Method from "panda-generics"
import {red, green, magenta} from "colors/safe"

tasks = {}
lookup = (name) -> tasks[name]

define = Method.create
  name: "define"
  description: "Defines a P9K task."

Method.define define, isString, isArray, isFunction,
  (name, dependencies, action) ->
    tasks[name] = {dependencies, action}

Method.define define, isString, isString, isFunction,
  (name, dependencies, action) ->
    define name, (dependencies.split /\s+/), action

Method.define define, isString, isDefined,
  (name, dependencies) -> define name, dependencies, ->

Method.define define, isString, isFunction,
  (name, action) -> define name, [], action

run = (name = "default", visited = []) ->

  flag = name[-1..]
  if flag == "&"
    background = true
    name = name[0..-2]

  unless name in visited

    console.error "[P9K] Starting #{green name} ..."

    visited.push name

    if (task = lookup name)?
      {dependencies, action} = task

      for dependency in dependencies
        await run dependency, visited

      start = microseconds()

      finish = ->
        finish = microseconds()
        duration = Math.round (finish - start)/1000
        console.error "[P9K] Finished #{green name} in #{magenta duration}ms."

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
      console.error red "[P9K] task #{green name} not found."

export {define, run}

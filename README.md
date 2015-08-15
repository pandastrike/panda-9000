# Introducing The Panda-9000

The Panda-9000, or P9K for short, is a task and dependency tool, similar to Gulp, but based on the Fairmont functional reactive programming library.

## Installation

```
npm install -g panda-9000
```

## Usage

Just run `p9k` with your task names. If you run `p9k` with no arguments, it will attempt to run the `default` task.

P9K looks for task definitions in the `tasks/index` directory.

## Defining Tasks

To define tasks, place a CoffeeScript or JavaScript file in your project's `task/index.coffee` or `tasks/index.js ` file.
This file should export a function that takes the P9K module object as an argument. This module includes all the P9K functions you need to define tasks.

For example, here's your standard _hello, world_ task.

```coffee
module.exports = ({task}) ->

  task "hello-world", ->
    console.log "Hello, World"
```

You can run this task like this:

```
p9k hello-world
```

Here's a more interesting example: compiling CoffeeScript files to JavaScript.

```coffee
{start, flow, async, map} = require "fairmont"

module.exports = (p9k) ->

  {task, glob, compileCoffeeScript, writeFile} = p9k

  task "compile-coffee", "directories", async ->
    yield start flow [
      yield glob "src/*.coffee"
      map compileCoffeeScript
      map writeFile "lib", ".js"
    ]
```

With this task, you can now run:

```
p9k compile-coffee
```

to compile your CoffeeScript files.

We can use this task to add a file-watcher task that will compile our CoffeeScript files whenever they change:

```coffee
{start, flow, async, map} = require "fairmont"

module.exports = (p9k) ->

  {task, glob, compileCoffeeScript, writeFile, watchFile} = p9k

  task "compile-coffee", "directories", async ->
    yield start flow [
      yield glob "src/*.coffee"
      map compileCoffeeScript
      map writeFile "lib", ".js"
    ]

  task "watch-coffee", async ->
    yield start flow [
      yield glob "src/*.coffee"
      map watchFile -> task "compile-coffee"
    ]
```

You see a [more detailed example][] in the [Fairmont Reactive][] Github repo.

[more detailed example]:https://github.com/pandastrike/fairmont-reactive/blob/master/examples/web-apps/counter/tasks/index.coffee
[Fairmont Reactive]:https://github.com/pandastrike/fairmont-reactive

## Status

The Panda-9000 is currently `alpha` status, meaning it's under heavy development and not yet suitable for production use.

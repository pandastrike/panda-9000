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
Import the task function from Panda-9000 and use it to define tasks and dependencies.

For example, here's a simple _hello, world_ task.

```coffee
{task} = require "panda-9000"

task "hello-world", ->
  console.log "Hello, World"
```

Run the task like this:

```
p9k hello-world
```

## Helpers

Panda-9000 provides a variety of built-in helpers you can use in tasks.
Helpers are designed to be used within reactive flows.

For example, here's a simple task that will take a list of CoffeeScript files in the `src` directory, compile them, and then write them out to `lib` with a `.js` extension.

```coffee
{go, async, map} = require "fairmont"
{task, glob, compileCoffeeScript, writeFile} = require "panda-9000"

module.exports = (p9k) ->

  task "compile-coffee", "directories", async ->
    yield go [
      glob "src/*.coffee"
      map compileCoffee
      map writeFile "lib"
    ]
```

Run the task via the command-line, as before:

```
p9k compile-coffee
```

## Pre-Defined Helpers

See [the wiki]() for a list of helpers and reference documentation for each.

## Defining Your Own Helpers

You can easily add your own helpers. See [the wiki]() for more information.

## Reactive Programming

Panda-9000 tasks often define reactive flows to perform tasks.
Check out
[an  example](https://github.com/pandastrike/fairmont-reactive/blob/master/examples/web-apps/counter/tasks/index.coffee)
in the
[Fairmont Reactive Github repo](https://github.com/pandastrike/fairmont-reactive).

## Status

The Panda-9000 is currently `alpha` status, meaning it's under heavy development and not yet suitable for production use.

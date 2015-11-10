# Introducing The Panda-9000

The Panda-9000, or P9K for short, is a task and dependency tool, similar to Gulp, but based on the Fairmont functional reactive programming library.

## Installation

```
npm install -g panda-9000
```

## Usage

```
p9k [<task-name>...]
```

If no arguments are given, the `default` task name is used.

Task definitions should be placed in the `tasks/index` directory.

## Defining Tasks

To define tasks, place a CoffeeScript or JavaScript file in your project's `task/index.coffee` or `tasks/index.js ` file.

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
Helpers are designed to be used within reactive flows using the [Fairmont][] FRP library.

For example, here's a simple task that will take a list of CoffeeScript files in the `src` directory, compile them, and then write them out to `lib` with a `.js` extension.

```coffee
{go, async, map, glob} = require "fairmont"
{task, context, coffee, write} = require "panda-9000"

task "coffee", async ->
  go [
    glob "**/*.coffee", "src"
    map context
    tee coffee
    tee write "lib"
  ]
```

Run the task via the command-line, as before:

```
p9k coffee
```

See the [API references](#reference) for more details.

## Reactive Programming

Panda-9000 tasks are typically defined as reactive flows using the Fairmont FRP library. [You can read the Fairmont wiki to learn more.][Fairmont]

## Status

The Panda-9000 is currently `alpha` status, meaning it's under heavy development and not yet suitable for production use.

[Fairmont]:https://github.com/pandastrike/fairmont/wiki/Reactive-Programming

## Documentation

[See the Panda-9000 wiki to learn more.](https://github.com/pandastrike/panda-9000/wiki)

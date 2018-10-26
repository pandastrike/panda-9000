# Introducing The Panda-9000

The Panda-9000, or P9K for short, is a task and dependency tool, similar to Gulp, but based on the reactive JavaScript library, [Panda River](/pandastrike/panda-river).

## Installation

```
npm i -g panda-9000
```

## Usage

```
p9k [<task-name>...]
```

If no arguments are given, the `default` task name is used.

Task definitions should be placed in the `tasks` directory.

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

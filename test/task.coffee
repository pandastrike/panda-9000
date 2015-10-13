{sleep} = require "fairmont"
{task} = require "../src/task"


task "A", "a-1", "a-2", "B"
task "B", "b-1", "b-2", "A"

task "a-1", -> sleep 2000, -> console.log "a-1"
task "a-2", -> console.log "a-2"
task "b-1", -> console.log "b-1"
task "b-2", -> console.log "b-2"

task "A"
# task "B"

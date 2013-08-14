{resolve} = require "path"
glob = require "panda-glob"
console.log glob(resolve("build"), "web/**/*")
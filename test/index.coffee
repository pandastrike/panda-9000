amen = require "amen"

amen.describe "First Order Tasks", (context) ->
  context.test "no arguments", require "./first-order/no-arguments"
  context.test "with arugments", require "./first-order/with-arguments"

amen.describe "Higher Order Tasks", (context) ->
  context.test "no arguments", require "./higher-order/no-arguments"
  context.test "with arguments", require "./higher-order/with-arguments"

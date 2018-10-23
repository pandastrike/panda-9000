"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.run = exports.define = void 0;

var _pandaParchment = require("panda-parchment");

var _pandaGenerics = require("panda-generics");

var define,
    lookup,
    run,
    tasks,
    indexOf = [].indexOf;
exports.run = run;
exports.define = define;
tasks = {};

lookup = function (name) {
  return tasks[name];
};

exports.define = define = _pandaGenerics.Method.create({
  description: "Define a task."
});

_pandaGenerics.Method.define(define, _pandaParchment.isString, _pandaParchment.isArray, _pandaParchment.isFunction, function (name, dependencies, action) {
  return tasks[name] = {
    dependencies,
    action
  };
});

_pandaGenerics.Method.define(define, _pandaParchment.isString, _pandaParchment.isFunction, function (name, action) {
  return define(name, [], action);
});

exports.run = run = async function (name = "default", visited = []) {
  var action, dependencies, dependency, duration, i, len;

  if (indexOf.call(visited, name) < 0) {
    console.log(`p9k: Starting ${name} ...`);
    visited.push(name);
    ({
      dependencies,
      action
    } = lookup(name));

    for (i = 0, len = dependencies.length; i < len; i++) {
      dependency = dependencies[i];
      await run(dependency, visited);
    }

    duration = Math.round((await (0, _pandaParchment.benchmark)(async function () {
      return await action();
    })) / 1000);
    return console.log(`p9k: Finished ${name} in ${duration}ms.`);
  }
};
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInRhc2suY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7Ozs7Ozs7QUFBQTs7QUFHQTs7QUFIQSxJQUFBLE1BQUE7QUFBQSxJQUFBLE1BQUE7QUFBQSxJQUFBLEdBQUE7QUFBQSxJQUFBLEtBQUE7QUFBQSxJQUFBLE9BQUEsR0FBQSxHQUFBLE9BQUE7OztBQUtBLEtBQUEsR0FBUSxFQUFSOztBQUNBLE1BQUEsR0FBUyxVQUFBLElBQUEsRUFBQTtTQUFVLEtBQU0sQ0FBQSxJQUFBLEM7QUFBaEIsQ0FBVDs7QUFFQSxpQkFBQSxNQUFBLEdBQVMsc0JBQUEsTUFBQSxDQUNQO0FBQUEsRUFBQSxXQUFBLEVBQWE7QUFBYixDQURPLENBQVQ7O0FBR0Esc0JBQUEsTUFBQSxDQUFBLE1BQUEsRUFBQSx3QkFBQSxFQUFBLHVCQUFBLEVBQUEsMEJBQUEsRUFDRSxVQUFBLElBQUEsRUFBQSxZQUFBLEVBQUEsTUFBQSxFQUFBO1NBQ0UsS0FBTSxDQUFOLElBQU0sQ0FBTixHQUFjO0FBQUEsSUFBQSxZQUFBO0FBQUEsSUFBQTtBQUFBLEc7QUFGbEIsQ0FBQTs7QUFJQSxzQkFBQSxNQUFBLENBQUEsTUFBQSxFQUFBLHdCQUFBLEVBQUEsMEJBQUEsRUFBNEMsVUFBQSxJQUFBLEVBQUEsTUFBQSxFQUFBO1NBQzFDLE1BQUEsQ0FBQSxJQUFBLEVBQUEsRUFBQSxFQUFBLE1BQUEsQztBQURGLENBQUE7O0FBR0EsY0FBQSxHQUFBLEdBQU0sZ0JBQUMsSUFBQSxHQUFELFNBQUEsRUFBbUIsT0FBQSxHQUFuQixFQUFBLEVBQUE7QUFDSixNQUFBLE1BQUEsRUFBQSxZQUFBLEVBQUEsVUFBQSxFQUFBLFFBQUEsRUFBQSxDQUFBLEVBQUEsR0FBQTs7QUFBQSxNQUFPLE9BQUEsQ0FBQSxJQUFBLENBQUEsT0FBQSxFQUFBLElBQUEsSUFBUCxDQUFBLEVBQUE7QUFDRSxJQUFBLE9BQU8sQ0FBUCxHQUFBLENBQVksaUJBQUEsSUFBWixNQUFBO0FBQ0EsSUFBQSxPQUFPLENBQVAsSUFBQSxDQUFBLElBQUE7QUFDQSxLQUFBO0FBQUEsTUFBQSxZQUFBO0FBQUEsTUFBQTtBQUFBLFFBQXlCLE1BQUEsQ0FBekIsSUFBeUIsQ0FBekI7O0FBQ2dDLFNBQUEsQ0FBQSxHQUFBLENBQUEsRUFBQSxHQUFBLEdBQUEsWUFBQSxDQUFBLE1BQUEsRUFBQSxDQUFBLEdBQUEsR0FBQSxFQUFBLENBQUEsRUFBQSxFQUFBOztBQUEvQixZQUFNLEdBQUEsQ0FBQSxVQUFBLEVBQU4sT0FBTSxDQUFOO0FBQStCOztBQUNoQyxJQUFBLFFBQUEsR0FBVyxJQUFJLENBQUosS0FBQSxDQUFXLENBQUMsTUFBTSwrQkFBVSxrQkFBQTtBQUFHLGFBQUEsTUFBTSxNQUFOLEVBQUE7QUFBcEIsS0FBTyxDQUFQLElBQVgsSUFBQSxDQUFYO1dBQ0EsT0FBTyxDQUFQLEdBQUEsQ0FBWSxpQkFBQSxJQUFBLE9BQUEsUUFOZCxLQU1FLEM7O0FBUEUsQ0FBTiIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCB7Y2FsbCwgY2F0LCBpbmNsdWRlcywgZW1wdHksIGlzU3RyaW5nLFxuICBpc0FycmF5LCBpc0Z1bmN0aW9uLCBpc0RlZmluZWQsIGlzT2JqZWN0LFxuICBiZW5jaG1hcmt9IGZyb20gXCJwYW5kYS1wYXJjaG1lbnRcIlxuaW1wb3J0IHtNZXRob2R9IGZyb20gXCJwYW5kYS1nZW5lcmljc1wiXG5cbnRhc2tzID0ge31cbmxvb2t1cCA9IChuYW1lKSAtPiB0YXNrc1tuYW1lXVxuXG5kZWZpbmUgPSBNZXRob2QuY3JlYXRlXG4gIGRlc2NyaXB0aW9uOiBcIkRlZmluZSBhIHRhc2suXCJcblxuTWV0aG9kLmRlZmluZSBkZWZpbmUsIGlzU3RyaW5nLCBpc0FycmF5LCBpc0Z1bmN0aW9uLFxuICAobmFtZSwgZGVwZW5kZW5jaWVzLCBhY3Rpb24pIC0+XG4gICAgdGFza3NbbmFtZV0gPSB7ZGVwZW5kZW5jaWVzLCBhY3Rpb259XG5cbk1ldGhvZC5kZWZpbmUgZGVmaW5lLCBpc1N0cmluZywgaXNGdW5jdGlvbiwgKG5hbWUsIGFjdGlvbikgLT5cbiAgZGVmaW5lIG5hbWUsIFtdLCBhY3Rpb25cblxucnVuID0gKG5hbWUgPSBcImRlZmF1bHRcIiwgdmlzaXRlZCA9IFtdKSAtPlxuICB1bmxlc3MgbmFtZSBpbiB2aXNpdGVkXG4gICAgY29uc29sZS5sb2cgXCJwOWs6IFN0YXJ0aW5nICN7bmFtZX0gLi4uXCJcbiAgICB2aXNpdGVkLnB1c2ggbmFtZVxuICAgIHtkZXBlbmRlbmNpZXMsIGFjdGlvbn0gPSBsb29rdXAgbmFtZVxuICAgIChhd2FpdCBydW4gZGVwZW5kZW5jeSwgdmlzaXRlZCkgZm9yIGRlcGVuZGVuY3kgaW4gZGVwZW5kZW5jaWVzXG4gICAgZHVyYXRpb24gPSBNYXRoLnJvdW5kIChhd2FpdCBiZW5jaG1hcmsgLT4gYXdhaXQgYWN0aW9uKCkpLzEwMDBcbiAgICBjb25zb2xlLmxvZyBcInA5azogRmluaXNoZWQgI3tuYW1lfSBpbiAje2R1cmF0aW9ufW1zLlwiXG5cbmV4cG9ydCB7ZGVmaW5lLCBydW59XG4iXSwic291cmNlUm9vdCI6IiJ9
//# sourceURL=task.coffee
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.run = exports.define = undefined;

var _pandaParchment = require("panda-parchment");

var _pandaRiver = require("panda-river");

var _pandaGenerics = require("panda-generics");

var define,
    lookup,
    run,
    tasks,
    indexOf = [].indexOf;

tasks = {};

lookup = function (name) {
  return tasks[name];
};

exports.define = define = _pandaGenerics.Method.create({
  description: "Define a task."
});

_pandaGenerics.Method.define(define, _pandaParchment.isString, _pandaParchment.isArray, _pandaParchment.isFunction, function (name, dependencies, action) {
  return tasks[name] = { dependencies, action };
});

_pandaGenerics.Method.define(define, _pandaParchment.isString, _pandaParchment.isFunction, function (name, action) {
  return define(name, [], action);
});

exports.run = run = async function (name = "default", visited = []) {
  var action, dependencies, dependency, duration, i, len;
  if (indexOf.call(visited, name) < 0) {
    console.log(`p9k: Starting ${name} ...`);
    visited.push(name);
    ({ dependencies, action } = lookup(name));
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

exports.define = define;
exports.run = run;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInRhc2suY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7Ozs7Ozs7QUFBQTs7QUFHQTs7QUFDQTs7QUFKQSxJQUFBLE1BQUE7QUFBQSxJQUFBLE1BQUE7QUFBQSxJQUFBLEdBQUE7QUFBQSxJQUFBLEtBQUE7QUFBQSxJQUFBLFVBQUEsR0FBQSxPQUFBOztBQU1BLFFBQVEsRUFBUjs7QUFDQSxTQUFTLFVBQUEsSUFBQSxFQUFBO1NBQVUsTUFBTSxJQUFOLEM7QUFBVixDQUFUOztBQUVBLFFBbUJBLE1BbkJBLFlBQVMsc0JBQUEsTUFBQSxDQUNQO0FBQUEsZUFBYTtBQUFiLENBRE8sQ0FBVDs7QUFHQSxzQkFBQSxNQUFBLENBQUEsTUFBQSxFQUFBLHdCQUFBLEVBQUEsdUJBQUEsRUFBQSwwQkFBQSxFQUNFLFVBQUEsSUFBQSxFQUFBLFlBQUEsRUFBQSxNQUFBLEVBQUE7U0FDRSxNQUFBLElBQUEsSUFBYyxFQUFBLFlBQUEsRUFBQSxNQUFBLEU7QUFGbEIsQ0FBQTs7QUFJQSxzQkFBQSxNQUFBLENBQUEsTUFBQSxFQUFBLHdCQUFBLEVBQUEsMEJBQUEsRUFBNEMsVUFBQSxJQUFBLEVBQUEsTUFBQSxFQUFBO1NBQzFDLE9BQUEsSUFBQSxFQUFBLEVBQUEsRUFBQSxNQUFBLEM7QUFERixDQUFBOztBQUdBLFFBU0EsR0FUQSxTQUFNLGdCQUFDLE9BQUQsU0FBQSxFQUFtQixVQUFuQixFQUFBLEVBQUE7QUFDSixNQUFBLE1BQUEsRUFBQSxZQUFBLEVBQUEsVUFBQSxFQUFBLFFBQUEsRUFBQSxDQUFBLEVBQUEsR0FBQTtBQUFBLE1BQU8sUUFBQSxJQUFBLENBQUEsT0FBQSxFQUFBLElBQUEsSUFBUCxDQUFBLEVBQUE7QUFDRSxZQUFBLEdBQUEsQ0FBWSxpQkFBQSxJQUFaLE1BQUE7QUFDQSxZQUFBLElBQUEsQ0FBQSxJQUFBO0FBQ0EsS0FBQSxFQUFBLFlBQUEsRUFBQSxNQUFBLEtBQXlCLE9BQXpCLElBQXlCLENBQXpCO0FBQ2dDLFNBQUEsSUFBQSxDQUFBLEVBQUEsTUFBQSxhQUFBLE1BQUEsRUFBQSxJQUFBLEdBQUEsRUFBQSxHQUFBLEVBQUE7O0FBQS9CLFlBQU0sSUFBQSxVQUFBLEVBQU4sT0FBTSxDQUFOO0FBQStCO0FBQ2hDLGVBQVcsS0FBQSxLQUFBLENBQVcsQ0FBQyxNQUFNLCtCQUFVLGtCQUFBO0FBQUcsYUFBQSxNQUFBLFFBQUE7QUFBcEIsS0FBTyxDQUFQLElBQVgsSUFBQSxDQUFYO1dBQ0EsUUFBQSxHQUFBLENBQVksaUJBQUEsSUFBQSxPQUFBLFFBTmQsS0FNRSxDOztBQVBFLENBQU47O1FBU0EsTSxHQUFBLE07UUFBQSxHLEdBQUEsRyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCB7Y2FsbCwgY2F0LCBpbmNsdWRlcywgZW1wdHksIGlzU3RyaW5nLFxuICBpc0FycmF5LCBpc0Z1bmN0aW9uLCBpc0RlZmluZWQsIGlzT2JqZWN0LFxuICBiZW5jaG1hcmt9IGZyb20gXCJwYW5kYS1wYXJjaG1lbnRcIlxuaW1wb3J0IHtnbywgbWFwLCBhbGwsIHdhaXR9IGZyb20gXCJwYW5kYS1yaXZlclwiXG5pbXBvcnQge01ldGhvZH0gZnJvbSBcInBhbmRhLWdlbmVyaWNzXCJcblxudGFza3MgPSB7fVxubG9va3VwID0gKG5hbWUpIC0+IHRhc2tzW25hbWVdXG5cbmRlZmluZSA9IE1ldGhvZC5jcmVhdGVcbiAgZGVzY3JpcHRpb246IFwiRGVmaW5lIGEgdGFzay5cIlxuXG5NZXRob2QuZGVmaW5lIGRlZmluZSwgaXNTdHJpbmcsIGlzQXJyYXksIGlzRnVuY3Rpb24sXG4gIChuYW1lLCBkZXBlbmRlbmNpZXMsIGFjdGlvbikgLT5cbiAgICB0YXNrc1tuYW1lXSA9IHtkZXBlbmRlbmNpZXMsIGFjdGlvbn1cblxuTWV0aG9kLmRlZmluZSBkZWZpbmUsIGlzU3RyaW5nLCBpc0Z1bmN0aW9uLCAobmFtZSwgYWN0aW9uKSAtPlxuICBkZWZpbmUgbmFtZSwgW10sIGFjdGlvblxuXG5ydW4gPSAobmFtZSA9IFwiZGVmYXVsdFwiLCB2aXNpdGVkID0gW10pIC0+XG4gIHVubGVzcyBuYW1lIGluIHZpc2l0ZWRcbiAgICBjb25zb2xlLmxvZyBcInA5azogU3RhcnRpbmcgI3tuYW1lfSAuLi5cIlxuICAgIHZpc2l0ZWQucHVzaCBuYW1lXG4gICAge2RlcGVuZGVuY2llcywgYWN0aW9ufSA9IGxvb2t1cCBuYW1lXG4gICAgKGF3YWl0IHJ1biBkZXBlbmRlbmN5LCB2aXNpdGVkKSBmb3IgZGVwZW5kZW5jeSBpbiBkZXBlbmRlbmNpZXNcbiAgICBkdXJhdGlvbiA9IE1hdGgucm91bmQgKGF3YWl0IGJlbmNobWFyayAtPiBhd2FpdCBhY3Rpb24oKSkvMTAwMFxuICAgIGNvbnNvbGUubG9nIFwicDlrOiBGaW5pc2hlZCAje25hbWV9IGluICN7ZHVyYXRpb259bXMuXCJcblxuZXhwb3J0IHtkZWZpbmUsIHJ1bn1cbiJdLCJzb3VyY2VSb290IjoiIn0=
//# sourceURL=task.coffee
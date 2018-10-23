"use strict";

require("coffeescript/register");

var _path = require("path");

var _index = require("./index");

var _pandaQuill = require("panda-quill");

var source, tasks;
tasks = process.argv.slice(2);
source = (0, _path.join)(process.cwd(), "tasks", "index");

(async function () {
  var i, len, name, results; // TODO add checks for .js or .litcoffee

  if (await (0, _pandaQuill.exist)(`${source}.coffee`)) {
    // import task from source
    require(source);

    if (tasks.length === 0) {
      return (0, _index.task)("default");
    } else {
      results = [];

      for (i = 0, len = tasks.length; i < len; i++) {
        name = tasks[i];
        results.push((0, _index.task)(name));
      }

      return results;
    }
  } else {
    console.error("Unable to find a tasks/index.{js,coffee} file");
    return process.exit(-1);
  }
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInJ1bm5lci5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7QUFBQTs7QUFDQTs7QUFDQTs7QUFDQTs7QUFIQSxJQUFBLE1BQUEsRUFBQSxLQUFBO0FBS0EsS0FBQSxHQUFRLE9BQU8sQ0FBQyxJQUFSLENBQWEsS0FBYixDQUFhLENBQWIsQ0FBUjtBQUNBLE1BQUEsR0FBVSxnQkFBSyxPQUFPLENBQVosR0FBSyxFQUFMLEVBQUEsT0FBQSxFQUFBLE9BQUEsQ0FBVjs7QUFFRyxDQUFBLGtCQUFBO0FBRUQsTUFBQSxDQUFBLEVBQUEsR0FBQSxFQUFBLElBQUEsRUFBQSxPQUFBLENBRkMsQzs7QUFFRCxNQUFHLE1BQU0sdUJBQU0sR0FBQSxNQUFmLFNBQVMsQ0FBVCxFQUFBOztBQUVFLElBQUEsT0FBQSxDQUFBLE1BQUEsQ0FBQTs7QUFDQSxRQUFHLEtBQUssQ0FBTCxNQUFBLEtBQUgsQ0FBQSxFQUFBO2FBQ0UsaUJBREYsU0FDRSxDO0FBREYsS0FBQSxNQUFBO0FBR2MsTUFBQSxPQUFBLEdBQUEsRUFBQTs7QUFBQSxXQUFBLENBQUEsR0FBQSxDQUFBLEVBQUEsR0FBQSxHQUFBLEtBQUEsQ0FBQSxNQUFBLEVBQUEsQ0FBQSxHQUFBLEdBQUEsRUFBQSxDQUFBLEVBQUEsRUFBQTs7cUJBQVgsaUJBQUEsSUFBQSxDO0FBQVc7O2FBSGQsTztBQUhGO0FBQUEsR0FBQSxNQUFBO0FBUUUsSUFBQSxPQUFPLENBQVAsS0FBQSxDQUFBLCtDQUFBO1dBQ0EsT0FBTyxDQUFQLElBQUEsQ0FBYSxDQVRmLENBU0UsQzs7QUFYSixDQUFHIiwic291cmNlc0NvbnRlbnQiOlsiaW1wb3J0IFwiY29mZmVlc2NyaXB0L3JlZ2lzdGVyXCJcbmltcG9ydCB7am9pbn0gZnJvbSBcInBhdGhcIlxuaW1wb3J0IHt0YXNrfSBmcm9tIFwiLi9pbmRleFwiXG5pbXBvcnQge2V4aXN0fSBmcm9tIFwicGFuZGEtcXVpbGxcIlxuXG50YXNrcyA9IHByb2Nlc3MuYXJndlsyLi5dXG5zb3VyY2UgPSAoam9pbiBwcm9jZXNzLmN3ZCgpLCBcInRhc2tzXCIsIFwiaW5kZXhcIilcblxuZG8gLT5cbiAgIyBUT0RPIGFkZCBjaGVja3MgZm9yIC5qcyBvciAubGl0Y29mZmVlXG4gIGlmIGF3YWl0IGV4aXN0IFwiI3tzb3VyY2V9LmNvZmZlZVwiXG4gICAgIyBpbXBvcnQgdGFzayBmcm9tIHNvdXJjZVxuICAgIHJlcXVpcmUgc291cmNlXG4gICAgaWYgdGFza3MubGVuZ3RoID09IDBcbiAgICAgIHRhc2sgXCJkZWZhdWx0XCJcbiAgICBlbHNlXG4gICAgICAodGFzayBuYW1lKSBmb3IgbmFtZSBpbiB0YXNrc1xuICBlbHNlXG4gICAgY29uc29sZS5lcnJvciBcIlVuYWJsZSB0byBmaW5kIGEgdGFza3MvaW5kZXgue2pzLGNvZmZlZX0gZmlsZVwiXG4gICAgcHJvY2Vzcy5leGl0IC0xXG4iXSwic291cmNlUm9vdCI6IiJ9
//# sourceURL=runner.coffee
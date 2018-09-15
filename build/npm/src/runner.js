"use strict";

require("coffee-script/register");

var _path = require("path");

var _index = require("./index");

var call, exist, read, source, tasks;

({ call, exist, read } = require("fairmont"));

tasks = process.argv.slice(2);

source = (0, _path.join)(process.cwd(), "tasks", "index");

(async function () {
  var i, len, name, results;
  // TODO add checks for .js or .litcoffee
  if (await exist(`${source}.coffee`)) {
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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInJ1bm5lci5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7QUFBQTs7QUFDQTs7QUFDQTs7QUFGQSxJQUFBLElBQUEsRUFBQSxLQUFBLEVBQUEsSUFBQSxFQUFBLE1BQUEsRUFBQSxLQUFBOztBQUlBLENBQUEsRUFBQSxJQUFBLEVBQUEsS0FBQSxFQUFBLElBQUEsS0FBc0IsUUFBdEIsVUFBc0IsQ0FBdEI7O0FBRUEsUUFBUSxRQUFRLElBQVIsQ0FBYSxLQUFiLENBQWEsQ0FBYixDQUFSOztBQUNBLFNBQVUsZ0JBQUssUUFBTCxHQUFLLEVBQUwsRUFBQSxPQUFBLEVBQUEsT0FBQSxDQUFWOztBQUVHLENBQUEsa0JBQUE7QUFFRCxNQUFBLENBQUEsRUFBQSxHQUFBLEVBQUEsSUFBQSxFQUFBLE9BQUE7O0FBQUEsTUFBRyxNQUFNLE1BQU0sR0FBQSxNQUFmLFNBQVMsQ0FBVCxFQUFBOztBQUVFLFlBQUEsTUFBQTtBQUNBLFFBQUcsTUFBQSxNQUFBLEtBQUgsQ0FBQSxFQUFBO2FBQ0UsaUJBREYsU0FDRSxDO0FBREYsS0FBQSxNQUFBO0FBR2MsZ0JBQUEsRUFBQTtBQUFBLFdBQUEsSUFBQSxDQUFBLEVBQUEsTUFBQSxNQUFBLE1BQUEsRUFBQSxJQUFBLEdBQUEsRUFBQSxHQUFBLEVBQUE7O3FCQUFYLGlCQUFBLElBQUEsQztBQUFXO2FBSGQsTztBQUhGO0FBQUEsR0FBQSxNQUFBO0FBUUUsWUFBQSxLQUFBLENBQUEsK0NBQUE7V0FDQSxRQUFBLElBQUEsQ0FBYSxDQVRmLENBU0UsQzs7QUFYSixDQUFHIiwic291cmNlc0NvbnRlbnQiOlsiaW1wb3J0IFwiY29mZmVlLXNjcmlwdC9yZWdpc3RlclwiXG5pbXBvcnQge2pvaW59IGZyb20gXCJwYXRoXCJcbmltcG9ydCB7dGFza30gZnJvbSBcIi4vaW5kZXhcIlxuXG57Y2FsbCwgZXhpc3QsIHJlYWR9ID0gcmVxdWlyZSBcImZhaXJtb250XCJcblxudGFza3MgPSBwcm9jZXNzLmFyZ3ZbMi4uXVxuc291cmNlID0gKGpvaW4gcHJvY2Vzcy5jd2QoKSwgXCJ0YXNrc1wiLCBcImluZGV4XCIpXG5cbmRvIC0+XG4gICMgVE9ETyBhZGQgY2hlY2tzIGZvciAuanMgb3IgLmxpdGNvZmZlZVxuICBpZiBhd2FpdCBleGlzdCBcIiN7c291cmNlfS5jb2ZmZWVcIlxuICAgICMgaW1wb3J0IHRhc2sgZnJvbSBzb3VyY2VcbiAgICByZXF1aXJlIHNvdXJjZVxuICAgIGlmIHRhc2tzLmxlbmd0aCA9PSAwXG4gICAgICB0YXNrIFwiZGVmYXVsdFwiXG4gICAgZWxzZVxuICAgICAgKHRhc2sgbmFtZSkgZm9yIG5hbWUgaW4gdGFza3NcbiAgZWxzZVxuICAgIGNvbnNvbGUuZXJyb3IgXCJVbmFibGUgdG8gZmluZCBhIHRhc2tzL2luZGV4Lntqcyxjb2ZmZWV9IGZpbGVcIlxuICAgIHByb2Nlc3MuZXhpdCAtMVxuIl0sInNvdXJjZVJvb3QiOiIifQ==
//# sourceURL=runner.coffee
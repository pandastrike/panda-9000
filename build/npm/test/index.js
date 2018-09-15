"use strict";

var _assert = require("assert");

var _assert2 = _interopRequireDefault(_assert);

var _path = require("path");

var _amen = require("amen");

var _src = require("../src");

var _pandaRiver = require("panda-river");

var _pandaQuill = require("panda-quill");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var src, target;

src = (0, _path.resolve)("test", "files");

target = (0, _path.resolve)("test", "build");

(async function () {
  return (0, _amen.print)((await (0, _amen.test)("Panda-9000", [(0, _amen.test)("define task", async function () {
    (0, _src.define)("clean", async function () {
      if (await (0, _pandaQuill.isDirectory)(target)) {
        await (0, _pandaRiver.start)((0, _pandaRiver.map)(_pandaQuill.rm, (await (0, _pandaQuill.lsr)(target))));
        return await (0, _pandaQuill.rmDir)(target);
      }
    });
    (0, _src.define)("poem", ["clean"], async function () {
      return (0, _pandaRiver.go)([await (0, _pandaQuill.glob)("*.txt", src), (0, _pandaRiver.map)((0, _src.context)(src)), (0, _pandaRiver.tee)(async function (context) {
        context.source.content = await (0, _pandaQuill.read)(context.source.path);
        return context.target.content = context.source.content + "whose fleece was white as snow.";
      }), _pandaRiver.wait, (0, _pandaRiver.tee)((0, _src.write)(target)), _pandaRiver.wait]);
    });
    await (0, _src.run)("poem");
    return _assert2.default.equal("Mary had a little lamb,\nwhose fleece was white as snow.", (await (0, _pandaQuill.read)((0, _path.join)(target, "poem.txt"))));
  })])));
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImluZGV4LmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOztBQUFBOzs7O0FBQ0E7O0FBQ0E7O0FBQ0E7O0FBQ0E7O0FBQ0E7Ozs7QUFMQSxJQUFBLEdBQUEsRUFBQSxNQUFBOztBQU9BLE1BQU0sbUJBQUEsTUFBQSxFQUFBLE9BQUEsQ0FBTjs7QUFDQSxTQUFTLG1CQUFBLE1BQUEsRUFBQSxPQUFBLENBQVQ7O0FBRUcsQ0FBQSxrQkFBQTtTQUNELGtCQUFNLE1BQU0sZ0JBQUEsWUFBQSxFQUFtQixDQUU3QixnQkFBQSxhQUFBLEVBQW9CLGtCQUFBO0FBRWxCLHFCQUFBLE9BQUEsRUFBZ0Isa0JBQUE7QUFDZCxVQUFHLE1BQU0sNkJBQVQsTUFBUyxDQUFULEVBQUE7QUFDRSxjQUFNLHVCQUFNLHFCQUFBLGNBQUEsR0FBUSxNQUFNLHFCQUFwQixNQUFvQixDQUFkLEVBQU4sQ0FBTjtBQUNBLGVBQUEsTUFBTSx1QkFGUixNQUVRLENBQU47O0FBSEosS0FBQTtBQUtBLHFCQUFBLE1BQUEsRUFBZSxDQUFmLE9BQWUsQ0FBZixFQUE0QixrQkFBQTthQUMxQixvQkFBRyxDQUNELE1BQU0sc0JBQUEsT0FBQSxFQURMLEdBQ0ssQ0FETCxFQUVELHFCQUFJLGtCQUZILEdBRUcsQ0FBSixDQUZDLEVBR0QscUJBQUksZ0JBQUEsT0FBQSxFQUFBO0FBQ0YsZ0JBQVEsTUFBUixDQUFBLE9BQUEsR0FBeUIsTUFBTSxzQkFBSyxRQUFRLE1BQVIsQ0FBWCxJQUFNLENBQS9CO2VBQ0EsUUFBUSxNQUFSLENBQUEsT0FBQSxHQUF5QixRQUFRLE1BQVIsQ0FBQSxPQUFBLEdBQ3ZCLGlDO0FBTkgsT0FHRCxDQUhDLEVBQUEsZ0JBQUEsRUFRRCxxQkFBSSxnQkFSSCxNQVFHLENBQUosQ0FSQyxFQUFBLGdCQUFBLENBQUgsQztBQURGLEtBQUE7QUFhQSxVQUFNLGNBQUEsTUFBQSxDQUFOO1dBRUEsaUJBQUEsS0FBQSxDQUFBLDBEQUFBLEdBQ0UsTUFBTSxzQkFBSyxnQkFBQSxNQUFBLEVBRGIsVUFDYSxDQUFMLENBRFIsRTtBQXhCMkIsR0FFN0IsQ0FGNkIsQ0FBbkIsQ0FBWixFO0FBREYsQ0FBRyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCBhc3NlcnQgZnJvbSBcImFzc2VydFwiXG5pbXBvcnQge3Jlc29sdmUsIGpvaW59IGZyb20gXCJwYXRoXCJcbmltcG9ydCB7cHJpbnQsIHRlc3R9IGZyb20gXCJhbWVuXCJcbmltcG9ydCB7ZGVmaW5lLCBydW4sIGNvbnRleHQsIHB1Zywgd3JpdGV9IGZyb20gXCIuLi9zcmNcIlxuaW1wb3J0IHtnbywgbWFwLCB0ZWUsIHdhaXQsIHN0YXJ0fSBmcm9tIFwicGFuZGEtcml2ZXJcIlxuaW1wb3J0IHtnbG9iLCByZWFkLCBpc0RpcmVjdG9yeSwgbHNyLCBybSwgcm1EaXJ9IGZyb20gXCJwYW5kYS1xdWlsbFwiXG5cbnNyYyA9IHJlc29sdmUgXCJ0ZXN0XCIsIFwiZmlsZXNcIlxudGFyZ2V0ID0gcmVzb2x2ZSBcInRlc3RcIiwgXCJidWlsZFwiXG5cbmRvIC0+XG4gIHByaW50IGF3YWl0IHRlc3QgXCJQYW5kYS05MDAwXCIsIFtcblxuICAgIHRlc3QgXCJkZWZpbmUgdGFza1wiLCAtPlxuXG4gICAgICBkZWZpbmUgXCJjbGVhblwiLCAtPlxuICAgICAgICBpZiBhd2FpdCBpc0RpcmVjdG9yeSB0YXJnZXRcbiAgICAgICAgICBhd2FpdCBzdGFydCBtYXAgcm0sIGF3YWl0IGxzciB0YXJnZXRcbiAgICAgICAgICBhd2FpdCBybURpciB0YXJnZXRcblxuICAgICAgZGVmaW5lIFwicG9lbVwiLCBbIFwiY2xlYW5cIiBdLCAtPlxuICAgICAgICBnbyBbXG4gICAgICAgICAgYXdhaXQgZ2xvYiBcIioudHh0XCIsIHNyY1xuICAgICAgICAgIG1hcCBjb250ZXh0IHNyY1xuICAgICAgICAgIHRlZSAoY29udGV4dCkgLT5cbiAgICAgICAgICAgIGNvbnRleHQuc291cmNlLmNvbnRlbnQgPSBhd2FpdCByZWFkIGNvbnRleHQuc291cmNlLnBhdGhcbiAgICAgICAgICAgIGNvbnRleHQudGFyZ2V0LmNvbnRlbnQgPSBjb250ZXh0LnNvdXJjZS5jb250ZW50ICtcbiAgICAgICAgICAgICAgXCJ3aG9zZSBmbGVlY2Ugd2FzIHdoaXRlIGFzIHNub3cuXCJcbiAgICAgICAgICB3YWl0XG4gICAgICAgICAgdGVlIHdyaXRlIHRhcmdldFxuICAgICAgICAgIHdhaXRcbiAgICAgICAgXVxuXG4gICAgICBhd2FpdCBydW4gXCJwb2VtXCJcblxuICAgICAgYXNzZXJ0LmVxdWFsIFwiTWFyeSBoYWQgYSBsaXR0bGUgbGFtYixcXG53aG9zZSBmbGVlY2Ugd2FzIHdoaXRlIGFzIHNub3cuXCIsXG4gICAgICAgIGF3YWl0IHJlYWQgam9pbiB0YXJnZXQsIFwicG9lbS50eHRcIlxuXG4gIF1cbiJdLCJzb3VyY2VSb290IjoiIn0=
//# sourceURL=index.coffee
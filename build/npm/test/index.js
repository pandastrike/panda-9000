"use strict";

var _assert = _interopRequireDefault(require("assert"));

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
      return (0, _pandaRiver.go)([await (0, _pandaQuill.glob)("*.txt", src), (0, _pandaRiver.map)((0, _src.context)(src)), (0, _pandaRiver.wait)((0, _pandaRiver.tee)(async function (context) {
        context.source.content = await (0, _pandaQuill.read)(context.source.path);
        return context.target.content = context.source.content + "whose fleece was white as snow.";
      })), (0, _pandaRiver.wait)((0, _pandaRiver.tee)((0, _src.write)(target)))]);
    });
    await (0, _src.run)("poem");
    return _assert.default.equal("Mary had a little lamb,\nwhose fleece was white as snow.", (await (0, _pandaQuill.read)((0, _path.join)(target, "poem.txt"))));
  })])));
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImluZGV4LmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOztBQUFBOztBQUNBOztBQUNBOztBQUNBOztBQUNBOztBQUNBOzs7O0FBTEEsSUFBQSxHQUFBLEVBQUEsTUFBQTtBQU9BLEdBQUEsR0FBTSxtQkFBQSxNQUFBLEVBQUEsT0FBQSxDQUFOO0FBQ0EsTUFBQSxHQUFTLG1CQUFBLE1BQUEsRUFBQSxPQUFBLENBQVQ7O0FBRUcsQ0FBQSxrQkFBQTtTQUNELGtCQUFNLE1BQU0sZ0JBQUEsWUFBQSxFQUFtQixDQUU3QixnQkFBQSxhQUFBLEVBQW9CLGtCQUFBO0FBRWxCLHFCQUFBLE9BQUEsRUFBZ0Isa0JBQUE7QUFDZCxVQUFHLE1BQU0sNkJBQVQsTUFBUyxDQUFULEVBQUE7QUFDRSxjQUFNLHVCQUFNLHFCQUFBLGNBQUEsR0FBUSxNQUFNLHFCQUFwQixNQUFvQixDQUFkLEVBQU4sQ0FBTjtBQUNBLGVBQUEsTUFBTSx1QkFGUixNQUVRLENBQU47O0FBSEosS0FBQTtBQUtBLHFCQUFBLE1BQUEsRUFBZSxDQUFmLE9BQWUsQ0FBZixFQUE0QixrQkFBQTthQUMxQixvQkFBRyxDQUNELE1BQU0sc0JBQUEsT0FBQSxFQURMLEdBQ0ssQ0FETCxFQUVELHFCQUFJLGtCQUZILEdBRUcsQ0FBSixDQUZDLEVBR0Qsc0JBQUsscUJBQUksZ0JBQUEsT0FBQSxFQUFBO0FBQ1AsUUFBQSxPQUFPLENBQUMsTUFBUixDQUFBLE9BQUEsR0FBeUIsTUFBTSxzQkFBSyxPQUFPLENBQUMsTUFBUixDQUFYLElBQU0sQ0FBL0I7ZUFDQSxPQUFPLENBQUMsTUFBUixDQUFBLE9BQUEsR0FBeUIsT0FBTyxDQUFDLE1BQVIsQ0FBQSxPQUFBLEdBQ3ZCLGlDO0FBTkgsT0FHSSxDQUFMLENBSEMsRUFPRCxzQkFBSyxxQkFBSSxnQkFQUixNQU9RLENBQUosQ0FBTCxDQVBDLENBQUgsQztBQURGLEtBQUE7QUFXQSxVQUFNLGNBQUEsTUFBQSxDQUFOO1dBRUEsZ0JBQUEsS0FBQSxDQUFBLDBEQUFBLEdBQ0UsTUFBTSxzQkFBSyxnQkFBQSxNQUFBLEVBRGIsVUFDYSxDQUFMLENBRFIsRTtBQXRCMkIsR0FFN0IsQ0FGNkIsQ0FBbkIsQ0FBWixFO0FBREYsQ0FBRyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCBhc3NlcnQgZnJvbSBcImFzc2VydFwiXG5pbXBvcnQge3Jlc29sdmUsIGpvaW59IGZyb20gXCJwYXRoXCJcbmltcG9ydCB7cHJpbnQsIHRlc3R9IGZyb20gXCJhbWVuXCJcbmltcG9ydCB7ZGVmaW5lLCBydW4sIGNvbnRleHQsIHdyaXRlfSBmcm9tIFwiLi4vc3JjXCJcbmltcG9ydCB7Z28sIG1hcCwgdGVlLCB3YWl0LCBzdGFydH0gZnJvbSBcInBhbmRhLXJpdmVyXCJcbmltcG9ydCB7Z2xvYiwgcmVhZCwgaXNEaXJlY3RvcnksIGxzciwgcm0sIHJtRGlyfSBmcm9tIFwicGFuZGEtcXVpbGxcIlxuXG5zcmMgPSByZXNvbHZlIFwidGVzdFwiLCBcImZpbGVzXCJcbnRhcmdldCA9IHJlc29sdmUgXCJ0ZXN0XCIsIFwiYnVpbGRcIlxuXG5kbyAtPlxuICBwcmludCBhd2FpdCB0ZXN0IFwiUGFuZGEtOTAwMFwiLCBbXG5cbiAgICB0ZXN0IFwiZGVmaW5lIHRhc2tcIiwgLT5cblxuICAgICAgZGVmaW5lIFwiY2xlYW5cIiwgLT5cbiAgICAgICAgaWYgYXdhaXQgaXNEaXJlY3RvcnkgdGFyZ2V0XG4gICAgICAgICAgYXdhaXQgc3RhcnQgbWFwIHJtLCBhd2FpdCBsc3IgdGFyZ2V0XG4gICAgICAgICAgYXdhaXQgcm1EaXIgdGFyZ2V0XG5cbiAgICAgIGRlZmluZSBcInBvZW1cIiwgWyBcImNsZWFuXCIgXSwgLT5cbiAgICAgICAgZ28gW1xuICAgICAgICAgIGF3YWl0IGdsb2IgXCIqLnR4dFwiLCBzcmNcbiAgICAgICAgICBtYXAgY29udGV4dCBzcmNcbiAgICAgICAgICB3YWl0IHRlZSAoY29udGV4dCkgLT5cbiAgICAgICAgICAgIGNvbnRleHQuc291cmNlLmNvbnRlbnQgPSBhd2FpdCByZWFkIGNvbnRleHQuc291cmNlLnBhdGhcbiAgICAgICAgICAgIGNvbnRleHQudGFyZ2V0LmNvbnRlbnQgPSBjb250ZXh0LnNvdXJjZS5jb250ZW50ICtcbiAgICAgICAgICAgICAgXCJ3aG9zZSBmbGVlY2Ugd2FzIHdoaXRlIGFzIHNub3cuXCJcbiAgICAgICAgICB3YWl0IHRlZSB3cml0ZSB0YXJnZXRcbiAgICAgICAgXVxuXG4gICAgICBhd2FpdCBydW4gXCJwb2VtXCJcblxuICAgICAgYXNzZXJ0LmVxdWFsIFwiTWFyeSBoYWQgYSBsaXR0bGUgbGFtYixcXG53aG9zZSBmbGVlY2Ugd2FzIHdoaXRlIGFzIHNub3cuXCIsXG4gICAgICAgIGF3YWl0IHJlYWQgam9pbiB0YXJnZXQsIFwicG9lbS50eHRcIlxuXG4gIF1cbiJdLCJzb3VyY2VSb290IjoiIn0=
//# sourceURL=index.coffee
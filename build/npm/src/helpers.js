"use strict";

var _path2 = require("path");

var _pandaGarden = require("panda-garden");

var _pandaParchment = require("panda-parchment");

var _pandaRiver = require("panda-river");

var _pandaQuill = require("panda-quill");

var _pug2 = require("pug");

var _pug3 = _interopRequireDefault(_pug2);

var _coffeescript = require("coffeescript");

var _coffeescript2 = _interopRequireDefault(_coffeescript);

var _stylus2 = require("stylus");

var _stylus3 = _interopRequireDefault(_stylus2);

var _pandaTemplate = require("panda-template");

var _pandaTemplate2 = _interopRequireDefault(_pandaTemplate);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var coffee, context, handlebars, parse, pug, stylus, write;

parse = function (path) {
  var dir, ext, name;
  ({ dir, name, ext } = (0, _path2.parse)(path));
  return {
    path: path,
    directory: dir,
    name: name,
    extension: ext
  };
};

context = (0, _pandaGarden.curry)(function (_directory, _path) {
  var directory, extension, name, path;
  ({ path, directory, name, extension } = parse(_path));
  return {
    path: (0, _path2.relative)(_directory, (0, _path2.join)(directory, name)),
    name: name,
    source: { path, directory, name, extension },
    target: {},
    data: {}
  };
});

// options exposes the Pug API's compile options.
pug = function (options = {}) {
  return async function ({ source, target, data }) {
    var render;
    if (source.content == null) {
      source.content = await (0, _pandaQuill.read)(source.path);
    }
    options.filename = source.path;
    render = _pug3.default.compile(source.content, options);
    return target.content = render(data);
  };
};

handlebars = async function ({ source, target, data }) {
  if (source.content == null) {
    source.content = await (0, _pandaQuill.read)(source.path);
  }
  return target.content = _handlebars(source.content, data);
};

stylus = async function ({ source, target }) {
  if (source.content == null) {
    source.content = await (0, _pandaQuill.read)(source.path);
  }
  return target.content = await (0, _pandaParchment.promise)(function (resolve, reject) {
    return _stylus3.default.render(source.content, {
      filename: source.path
    }, function (error, css) {
      if (error == null) {
        return resolve(css);
      } else {
        return reject(error);
      }
    });
  });
};

coffee = async function ({ source, target }) {
  if (source.content == null) {
    source.content = await (0, _pandaQuill.read)(source.path);
  }
  return target.content = _coffeescript2.default.compile(source.content);
};

write = (0, _pandaGarden.curry)((0, _pandaGarden.binary)(async function (directory, { path, target, source }) {
  var extension;
  if (target.content != null) {
    if (target.path == null) {
      extension = target.extension != null ? target.extension : source.extension != null ? source.extension : "";
      (0, _pandaParchment.include)(target, parse((0, _path2.join)(directory, `${path}${extension}`)));
    }
    await (0, _pandaQuill.mkdirp)("0777", target.directory);
    return await (0, _pandaQuill.write)(target.path, target.content);
  }
}));

module.exports = { context, pug, stylus, coffee, write, handlebars };
//# sourceMappingURL=data:application/json;base64,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WixFQUFBO0FBQ25CLE1BQUEsU0FBQTtBQUFBLE1BQUcsT0FBQSxPQUFBLElBQUgsSUFBQSxFQUFBO0FBQ0UsUUFBSSxPQUFBLElBQUEsSUFBSixJQUFBLEVBQUE7QUFDRSxrQkFBZSxPQUFBLFNBQUEsSUFBSCxJQUFHLEdBQ2IsT0FEVSxTQUFHLEdBRVAsT0FBQSxTQUFBLElBQUgsSUFBRyxHQUNOLE9BREcsU0FBRyxHQUVILEVBSkw7QUFLQSxtQ0FBQSxNQUFBLEVBQ0UsTUFBTyxpQkFBQSxTQUFBLEVBQWdCLEdBQUEsSUFBQSxHQUFBLFNBUDNCLEVBT1csQ0FBUCxDQURGOztBQUVGLFVBQU0sd0JBQUEsTUFBQSxFQUFnQixPQUFoQixTQUFBLENBQU47QUFDQSxXQUFBLE1BQU0sdUJBQU8sT0FBUCxJQUFBLEVBQW9CLE9BVjVCLE9BVVEsQ0FBTjs7QUFYSSxDQUFNLENBQU4sQ0FBUjs7QUFhQSxPQUFBLE9BQUEsR0FBaUIsRUFBQSxPQUFBLEVBQUEsR0FBQSxFQUFBLE1BQUEsRUFBQSxNQUFBLEVBQUEsS0FBQSxFQUFBLFVBQUEsRUFBakIiLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQge3BhcnNlIGFzIF9wYXJzZSwgcmVsYXRpdmUsIGpvaW59IGZyb20gIFwicGF0aFwiXG5pbXBvcnQge2N1cnJ5LCBiaW5hcnl9IGZyb20gXCJwYW5kYS1nYXJkZW5cIlxuaW1wb3J0IHtwcm9taXNlLCBpbmNsdWRlfSBmcm9tIFwicGFuZGEtcGFyY2htZW50XCJcbmltcG9ydCB7ZmxvdywgbWFwfSBmcm9tIFwicGFuZGEtcml2ZXJcIlxuaW1wb3J0IHtnbG9iLCByZWFkLCB3cml0ZSBhcyBfd3JpdGUsIG1rZGlycH0gZnJvbSBcInBhbmRhLXF1aWxsXCJcbmltcG9ydCBfcHVnIGZyb20gXCJwdWdcIlxuaW1wb3J0IF9jb2ZmZWUgZnJvbSBcImNvZmZlZXNjcmlwdFwiXG5pbXBvcnQgX3N0eWx1cyBmcm9tIFwic3R5bHVzXCJcbmltcG9ydCBfdGVtcGxhdGUgZnJvbSBcInBhbmRhLXRlbXBsYXRlXCJcblxucGFyc2UgPSAocGF0aCkgLT5cbiAge2RpciwgbmFtZSwgZXh0fSA9IF9wYXJzZSBwYXRoXG4gIHBhdGg6IHBhdGhcbiAgZGlyZWN0b3J5OiBkaXJcbiAgbmFtZTogbmFtZVxuICBleHRlbnNpb246IGV4dFxuXG5jb250ZXh0ID0gY3VycnkgKF9kaXJlY3RvcnksIF9wYXRoKSAtPlxuICB7cGF0aCwgZGlyZWN0b3J5LCBuYW1lLCBleHRlbnNpb259ID0gcGFyc2UgX3BhdGhcbiAgcGF0aDogcmVsYXRpdmUgX2RpcmVjdG9yeSwgKGpvaW4gZGlyZWN0b3J5LCBuYW1lKVxuICBuYW1lOiBuYW1lXG4gIHNvdXJjZToge3BhdGgsIGRpcmVjdG9yeSwgbmFtZSwgZXh0ZW5zaW9ufVxuICB0YXJnZXQ6IHt9XG4gIGRhdGE6IHt9XG5cbiMgb3B0aW9ucyBleHBvc2VzIHRoZSBQdWcgQVBJJ3MgY29tcGlsZSBvcHRpb25zLlxucHVnID0gKG9wdGlvbnM9e30pIC0+XG4gICh7c291cmNlLCB0YXJnZXQsIGRhdGF9KSAtPlxuICAgIHNvdXJjZS5jb250ZW50ID89IGF3YWl0IHJlYWQgc291cmNlLnBhdGhcbiAgICBvcHRpb25zLmZpbGVuYW1lID0gc291cmNlLnBhdGhcbiAgICByZW5kZXIgPSBfcHVnLmNvbXBpbGUgc291cmNlLmNvbnRlbnQsIG9wdGlvbnNcbiAgICB0YXJnZXQuY29udGVudCA9IHJlbmRlciBkYXRhXG5cbmhhbmRsZWJhcnMgPSAoe3NvdXJjZSwgdGFyZ2V0LCBkYXRhfSkgLT5cbiAgc291cmNlLmNvbnRlbnQgPz0gYXdhaXQgcmVhZCBzb3VyY2UucGF0aFxuICB0YXJnZXQuY29udGVudCA9IF9oYW5kbGViYXJzIHNvdXJjZS5jb250ZW50LCBkYXRhXG5cbnN0eWx1cyA9ICh7c291cmNlLCB0YXJnZXR9KSAtPlxuICBzb3VyY2UuY29udGVudCA/PSBhd2FpdCByZWFkIHNvdXJjZS5wYXRoXG4gIHRhcmdldC5jb250ZW50ID0gYXdhaXQgcHJvbWlzZSAocmVzb2x2ZSwgcmVqZWN0KSAtPlxuICAgIF9zdHlsdXMucmVuZGVyIHNvdXJjZS5jb250ZW50LCBmaWxlbmFtZTogc291cmNlLnBhdGgsXG4gICAgICAoZXJyb3IsIGNzcykgLT4gdW5sZXNzIGVycm9yPyB0aGVuIHJlc29sdmUgY3NzIGVsc2UgcmVqZWN0IGVycm9yXG5cbmNvZmZlZSA9ICh7c291cmNlLCB0YXJnZXR9KSAtPlxuICBzb3VyY2UuY29udGVudCA/PSBhd2FpdCByZWFkIHNvdXJjZS5wYXRoXG4gIHRhcmdldC5jb250ZW50ID0gX2NvZmZlZS5jb21waWxlIHNvdXJjZS5jb250ZW50XG5cbndyaXRlID0gY3VycnkgYmluYXJ5IChkaXJlY3RvcnksIHtwYXRoLCB0YXJnZXQsIHNvdXJjZX0pIC0+XG4gIGlmIHRhcmdldC5jb250ZW50P1xuICAgIGlmICF0YXJnZXQucGF0aD9cbiAgICAgIGV4dGVuc2lvbiA9IGlmIHRhcmdldC5leHRlbnNpb24/XG4gICAgICAgIHRhcmdldC5leHRlbnNpb25cbiAgICAgIGVsc2UgaWYgc291cmNlLmV4dGVuc2lvbj9cbiAgICAgICAgc291cmNlLmV4dGVuc2lvblxuICAgICAgZWxzZSBcIlwiXG4gICAgICBpbmNsdWRlIHRhcmdldCxcbiAgICAgICAgcGFyc2UgKGpvaW4gZGlyZWN0b3J5LCBcIiN7cGF0aH0je2V4dGVuc2lvbn1cIilcbiAgICBhd2FpdCBta2RpcnAgXCIwNzc3XCIsICh0YXJnZXQuZGlyZWN0b3J5KVxuICAgIGF3YWl0IF93cml0ZSB0YXJnZXQucGF0aCwgdGFyZ2V0LmNvbnRlbnRcblxubW9kdWxlLmV4cG9ydHMgPSB7Y29udGV4dCwgcHVnLCBzdHlsdXMsIGNvZmZlZSwgd3JpdGUsIGhhbmRsZWJhcnN9XG4iXSwic291cmNlUm9vdCI6IiJ9
//# sourceURL=helpers.coffee
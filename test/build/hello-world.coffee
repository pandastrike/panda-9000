(function() {
  hello(function() {
    return console.log("Hello, World");
  });

}).call(this);

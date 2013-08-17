require.config
  deps: ["modernizr", "app"]
  paths:
    modernizr: "../bower_components/modernizr/modernizr"
    jquery: "../bower_components/jquery/jquery"
    underscore: "../bower_components/underscore/underscore"
    backbone: "../bower_components/backbone/backbone"
    react: "../bower_components/react/react"
  shim:
    backbone:
      deps: ["jquery", "underscore"]
      exports: "Backbone"

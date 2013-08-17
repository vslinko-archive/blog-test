require.config
  paths:
    modernizr: "../bower_components/modernizr/modernizr"
    jquery: "../bower_components/jquery/jquery"

require ["modernizr", "jquery", "app"], (modernizr, $, app) ->
  console.log app

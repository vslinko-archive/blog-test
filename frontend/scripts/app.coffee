require ["backbone", "router"], (Backbone, router) ->
  Backbone.history.start()

  unless location.hash.match /^#!/
    router.navigate "!/", trigger: true

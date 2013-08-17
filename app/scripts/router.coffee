define [
  "backbone"
  "react"
  "components/main-page"
  "components/posts-page"
], (Backbone, React, MainPage, PostsPage) ->
  contentNode = document.getElementById "content"

  renderPage = (Page, attributeNames = []) ->
    ->
      attributes = {}
      for attributeName, i in attributeNames
        attributes[attributeName] = arguments[i]
      React.renderComponent Page(attributes), contentNode

  Router = Backbone.Router.extend
    routes:
      "!/": renderPage MainPage
      "!/posts": renderPage PostsPage

  new Router

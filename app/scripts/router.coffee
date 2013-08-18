define [
  "backbone"
  "react"
  "components/main-page"
  "components/posts-page"
  "components/post-page"
], (Backbone, React, MainPage, PostsPage, PostPage) ->
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
      "!/posts/:id": renderPage PostPage, ["_id"]

  new Router

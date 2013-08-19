define ["react", "collections/posts", "models/post"], (React, posts, Post) ->
  {div, h1, p} = React.DOM

  React.createClass
    getInitialState: ->
      post: posts.get @props._id

    componentWillMount: ->
      posts.on "reset", ->
        @setState post: posts.get @props._id
      , @

    componentWillUnmount: ->
      posts.off null, null, @

    render: ->
      return div() unless @state.post

      (div {},
        (h1 {}, @state.post.get "title"),
        (p {}, @state.post.get "text")
      )

define ["react", "models/post"], (React, Post) ->
  {div, h2, p} = React.DOM

  React.createClass
    getDefaultProps: ->
      post: new Post

    render: ->
      (div {},
        (h2 {}, @props.post.get "title"),
        (p {}, @props.post.get "text")
      )

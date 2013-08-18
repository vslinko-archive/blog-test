define ["react", "models/post"], (React, Post) ->
  {div, h2, p, a} = React.DOM

  React.createClass
    getDefaultProps: ->
      post: new Post

    render: ->
      (div {},
        (h2 {},
          (a {href: "#!/posts/#{@props.post.get "_id"}"}, @props.post.get "title")
        ),
        (p {}, @props.post.get "text")
      )

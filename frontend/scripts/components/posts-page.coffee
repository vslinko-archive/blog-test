define ["react", "components/posts"], (React, Posts) ->
  {div, h1} = React.DOM

  React.createClass
    render: ->
      (div {},
        (h1 {}, "All Posts"),
        (Posts {})
      )

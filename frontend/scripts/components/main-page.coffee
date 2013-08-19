define ["react", "components/posts"], (React, Posts) ->
  {div, h1} = React.DOM

  React.createClass
    render: ->
      (div {},
        (h1 {}, "Main Page"),
        (Posts {limit: 3})
      )

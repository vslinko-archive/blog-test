define ["react"], (React) ->
  React.createClass
    render: ->
      {div, h1} = React.DOM

      (div {},
        (h1 {}, "All Posts")
      )

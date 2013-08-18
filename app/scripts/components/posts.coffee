define ["react", "collections/posts", "components/post"], (React, posts, Post) ->
  {div} = React.DOM

  React.createClass
    getDefaultProps: ->
      limit: null

    getInitialState: ->
      posts: posts

    componentWillMount: ->
      posts.on "reset", ->
        @setState posts: posts
      , @

    componentWillUnmount: ->
      posts.off null, null, @

    filteredPosts: ->
      if @props.limit
        @state.posts.slice 0, @props.limit
      else
        @state.posts.toArray()

    render: ->
      (div {},
        (Post(post: post, key: i) for post, i in @filteredPosts())
      )

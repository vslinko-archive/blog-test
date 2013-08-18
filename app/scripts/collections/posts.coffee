define ["backbone", "models/post"], (Backbone, Post) ->
  Posts = Backbone.Collection.extend
    model: Post
    url: "/posts"

  posts = new Posts
  posts.fetch reset: true
  posts

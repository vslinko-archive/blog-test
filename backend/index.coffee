express = require "express"
path = require "path"

module.exports = app = express()

app.use express.static path.resolve path.join __dirname, "..", "frontend"

app.get "/posts", (req, res) ->
  postsArray = []
  for i in [1..10]
    postsArray.push
      _id: i
      title: "Post ##{i}"
      text: ("test" for j in [0...i]).join " "

  res.send 200, postsArray

if require.main is module
  app.listen 3000

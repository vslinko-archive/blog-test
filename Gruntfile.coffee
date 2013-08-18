loadGruntTasks = require "load-grunt-tasks"


module.exports = (grunt) ->
  loadGruntTasks grunt

  grunt.initConfig
    clean:
      dist:
        files: [
          dot: true
          src: [
            ".tmp"
            "dist/*"
            "!dist/.git*"
          ]
        ]
      server: ".tmp"
    jade:
      options:
        pretty: true
      dist:
        files: [
          expand: true
          cwd: "app"
          src: "{,*/}*.jade"
          dest: ".tmp"
          ext: ".html"
        ]
    stylus:
      dist:
        files: [
          expand: true
          cwd: "app/styles"
          src: "{,*/}*.styl"
          dest: ".tmp/styles"
          ext: ".css"
        ]
    coffee:
      dist:
        files: [
          expand: true
          cwd: "app/scripts"
          src: "{,*/}*.coffee"
          dest: ".tmp/scripts"
          ext: ".js"
        ]
    imagemin:
      dist:
        files: [
          expand: true
          cwd: "app/images"
          src: "{,*/}*.{png,jpg,jpeg}"
          dest: "dist/images"
        ]
    svgmin:
      dist:
        files: [
          expand: true
          cwd: "app/images"
          src: "{,*/}*.svg"
          dest: "dist/images"
        ]
    copy:
      dist:
        files: [
          {
            expand: true
            dot: true
            cwd: "app"
            dest: "dist"
            src: [
              "*.{ico,png,txt}"
              "bower_components/bootstrap/dist/css/bootstrap.css"
              "bower_components/requirejs/require.js"
              "images/{,*/}*.{webp,gif}"
              "styles/fonts/*"
            ]
          }
          {
            expand: true
            dot: true
            cwd: ".tmp"
            dest: "dist"
            src: [
              "{,*/}*.html"
              "styles/{,*/}*.css"
            ]
          }
        ]
      bower_components:
        files: [
          expand: true
          dot: true
          cwd: "app/bower_components"
          dest: ".tmp/bower_components"
          src: ["**"]
        ]
    useminPrepare:
      options:
        dest: "dist"
      html: "dist/index.html"
    requirejs:
      dist:
        options:
          baseUrl: ".tmp/scripts"
          optimize: "none"
          useStrict: true
          wrap: true
    rev:
      dist:
        files:
          src: [
            "dist/scripts/{,*/}*.js"
            "dist/styles/{,*/}*.css"
            "dist/images/{,*/}*.{png,jpg,jpeg,gif,webp}"
            "dist/styles/fonts/*"
          ]
    usemin:
      options:
        dirs: ["dist"]
      html: ["dist/{,*/}*.html"],
      css: ["dist/styles/{,*/}*.css"]
    htmlmin:
      options:
        removeComments: true
        collapseWhitespace: true
        collapseBooleanAttributes: true
        removeAttributeQuotes: true
        removeRedundantAttributes: true
      dist:
        files: [
          expand: true
          cwd: "dist"
          dest: "dist"
          src: ["{,*/}*.html"]
        ]
    express:
      options:
        hostname: "0.0.0.0"
      livereload:
        options:
          bases: [
            ".tmp"
            "app"
          ]
          server: "backend"
          livereload: true
      dist:
        options:
          bases: "dist"
          server: "backend"
    watch:
      jade:
        files: ["app/{,*/}*.jade"]
        tasks: ["jade"]
      stylus:
        files: ["app/styles/{,*/}*.styl"]
        tasks: ["stylus"]
      coffee:
        files: ["app/scripts/{,*/}*.coffee"]
        tasks: ["coffee"]
    concurrent:
      server: [
        "jade"
        "stylus"
        "coffee"
      ]
      dist: [
        "jade"
        "stylus"
        "coffee"
        "imagemin"
        "svgmin"
      ]

  grunt.registerTask "server", (target) ->
    if target is "dist"
      grunt.task.run [
        "build"
        "express-keepalive:dist"
      ]
    else
      grunt.task.run [
        "clean:server"
        "concurrent:server"
        "express:livereload"
        "watch"
      ]

  grunt.registerTask "build", [
    "clean:dist"
    "concurrent:dist"
    "copy"
    "useminPrepare"
    "requirejs"
    "concat"
    "uglify"
    "rev"
    "usemin"
    "htmlmin"
  ]

  grunt.registerTask "default", [
    "build"
  ]

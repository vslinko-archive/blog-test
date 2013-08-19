loadGruntTasks = require "load-grunt-tasks"


module.exports = (grunt) ->
  loadGruntTasks grunt

  yeomanConfig =
    app: "app"
    dist: "dist"

  grunt.initConfig
    yeoman: yeomanConfig
    clean:
      dist:
        files: [
          dot: true
          src: [
            ".tmp"
            "<%= yeoman.dist %>/*"
            "!<%= yeoman.dist %>/.git*"
          ]
        ]
      server: ".tmp"
    jade:
      options:
        pretty: true
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.app %>"
          src: "{,*/}*.jade"
          dest: ".tmp"
          ext: ".html"
        ]
    stylus:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.app %>/styles"
          src: "{,*/}*.styl"
          dest: ".tmp/styles"
          ext: ".css"
        ]
    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.app %>/scripts"
          src: "{,*/}*.coffee"
          dest: ".tmp/scripts"
          ext: ".js"
        ]
    imagemin:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.app %>/images"
          src: "{,*/}*.{png,jpg,jpeg}"
          dest: "<%= yeoman.dist %>/images"
        ]
    svgmin:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.app %>/images"
          src: "{,*/}*.svg"
          dest: "<%= yeoman.dist %>/images"
        ]
    copy:
      dist:
        files: [
          {
            expand: true
            dot: true
            cwd: "<%= yeoman.app %>"
            dest: "<%= yeoman.dist %>"
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
            dest: "<%= yeoman.dist %>"
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
          cwd: "<%= yeoman.app %>/bower_components"
          dest: ".tmp/bower_components"
          src: ["**"]
        ]
    useminPrepare:
      options:
        dest: "<%= yeoman.dist %>"
      html: "<%= yeoman.dist %>/index.html"
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
            "<%= yeoman.dist %>/scripts/{,*/}*.js"
            "<%= yeoman.dist %>/styles/{,*/}*.css"
            "<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}"
            "<%= yeoman.dist %>/styles/fonts/*"
          ]
    usemin:
      options:
        dirs: ["<%= yeoman.dist %>"]
      html: ["<%= yeoman.dist %>/{,*/}*.html"],
      css: ["<%= yeoman.dist %>/styles/{,*/}*.css"]
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
          cwd: "<%= yeoman.dist %>"
          dest: "<%= yeoman.dist %>"
          src: ["{,*/}*.html"]
        ]
    express:
      options:
        hostname: "0.0.0.0"
      livereload:
        options:
          bases: [
            ".tmp"
            "<%= yeoman.app %>"
          ]
          server: "backend"
          livereload: true
      dist:
        options:
          bases: "<%= yeoman.dist %>"
          server: "backend"
    watch:
      jade:
        files: ["<%= yeoman.app %>/{,*/}*.jade"]
        tasks: ["jade"]
      stylus:
        files: ["<%= yeoman.app %>/styles/{,*/}*.styl"]
        tasks: ["stylus"]
      coffee:
        files: ["<%= yeoman.app %>/scripts/{,*/}*.coffee"]
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

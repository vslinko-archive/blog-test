loadGruntTasks = require "load-grunt-tasks"


module.exports = (grunt) ->
  loadGruntTasks grunt

  yeomanConfig =
    frontend:
      app: "frontend"
      dist: "build/frontend"
    backend:
      app: "backend"
      dist: "build/backend"

  grunt.initConfig
    yeoman: yeomanConfig
    clean:
      dist:
        files: [
          dot: true
          src: [
            ".tmp"
            "<%= yeoman.frontend.dist %>/*"
            "!<%= yeoman.frontend.dist %>/.git*"
          ]
        ]
      server: ".tmp"
    jade:
      options:
        pretty: true
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.frontend.app %>"
          src: "{,*/}*.jade"
          dest: ".tmp"
          ext: ".html"
        ]
    stylus:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.frontend.app %>/styles"
          src: "{,*/}*.styl"
          dest: ".tmp/styles"
          ext: ".css"
        ]
    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.frontend.app %>/scripts"
          src: "{,*/}*.coffee"
          dest: ".tmp/scripts"
          ext: ".js"
        ]
      backend:
        files: [
          expand: true
          cwd: "<%= yeoman.backend.app %>"
          src: "**/*.coffee"
          dest: "<%= yeoman.backend.dist %>"
          ext: ".js"
        ]
    imagemin:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.frontend.app %>/images"
          src: "{,*/}*.{png,jpg,jpeg}"
          dest: "<%= yeoman.frontend.dist %>/images"
        ]
    svgmin:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.frontend.app %>/images"
          src: "{,*/}*.svg"
          dest: "<%= yeoman.frontend.dist %>/images"
        ]
    copy:
      dist:
        files: [
          {
            expand: true
            dot: true
            cwd: "<%= yeoman.frontend.app %>"
            dest: "<%= yeoman.frontend.dist %>"
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
            dest: "<%= yeoman.frontend.dist %>"
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
          cwd: "<%= yeoman.frontend.app %>/bower_components"
          dest: ".tmp/bower_components"
          src: ["**"]
        ]
      backend:
        files: [
          expand: true
          dot: true
          cwd: "."
          dest: "<%= yeoman.backend.dist %>"
          src: [
            "node_modules/**/*"
          ]
        ]
    useminPrepare:
      options:
        dest: "<%= yeoman.frontend.dist %>"
      html: "<%= yeoman.frontend.dist %>/index.html"
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
            "<%= yeoman.frontend.dist %>/scripts/{,*/}*.js"
            "<%= yeoman.frontend.dist %>/styles/{,*/}*.css"
            "<%= yeoman.frontend.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}"
            "<%= yeoman.frontend.dist %>/styles/fonts/*"
          ]
    usemin:
      options:
        dirs: ["<%= yeoman.frontend.dist %>"]
      html: ["<%= yeoman.frontend.dist %>/{,*/}*.html"],
      css: ["<%= yeoman.frontend.dist %>/styles/{,*/}*.css"]
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
          cwd: "<%= yeoman.frontend.dist %>"
          dest: "<%= yeoman.frontend.dist %>"
          src: ["{,*/}*.html"]
        ]
    express:
      options:
        hostname: "0.0.0.0"
      livereload:
        options:
          bases: [
            ".tmp"
          ]
          server: "backend"
          livereload: true
      dist:
        options:
          server: "<%= yeoman.backend.dist %>"
    watch:
      jade:
        files: ["<%= yeoman.frontend.app %>/{,*/}*.jade"]
        tasks: ["jade"]
      stylus:
        files: ["<%= yeoman.frontend.app %>/styles/{,*/}*.styl"]
        tasks: ["stylus"]
      coffee:
        files: ["<%= yeoman.frontend.app %>/scripts/{,*/}*.coffee"]
        tasks: ["coffee:dist"]
    concurrent:
      server: [
        "jade"
        "stylus"
        "coffee:dist"
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
        "express:dist"
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
    "cssmin"
    "uglify"
    "rev"
    "usemin"
    "htmlmin"
  ]

  grunt.registerTask "default", [
    "build"
  ]

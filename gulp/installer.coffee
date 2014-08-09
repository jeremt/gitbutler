
gulp = require "gulp"
gutil = require "gulp-util"
NwBuilder = require "node-webkit-builder"
Builder = require "./builder"
path = require "path"

class Installer extends Builder

  DEFAULT_OPTIONS =
    name: "MyApp"
    src: "./app"
    dest: "./build"
    platforms: ["win", "osx", "linux32", "linux64"]

  constructor: ({@src, @dest, @name} = {}) ->
    Builder.call(@)
    @name ?= DEFAULT_OPTIONS.name
    @src ?= DEFAULT_OPTIONS.src
    @dest ?= DEFAULT_OPTIONS.dest

  buildApp: ({platforms} = {}) ->
    platforms ?= DEFAULT_OPTIONS.platforms
    nw = new NwBuilder({
        version: '0.9.2',
        files: [path.join(@src, '**')],
        platforms: platforms,
        macIcns: './icon.icns',
         # winIco: './logo.ico'
    })

    # Log stuff you want
    nw.on('log', (msg) -> gutil.log('node-webkit-builder', msg))

    # Build returns a promise, return it so the task isn't called in parallel
    return nw.build().catch((err) ->
      gutil.log('node-webkit-builder', err)
    )

  installMac: ->
    gulp.src(path.join(@dest, "#{@name}/osx/node-webkit.app/**"))
      .pipe(gulp.dest("/Applications/#{@name}.app"))

module.exports = Installer
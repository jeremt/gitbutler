
gulp        = require "gulp"
Installer   = require "./installer"
Compiler    = require "./compiler"
Vendors     = require "./vendors"
misc        = require "./misc"
pkg         = require "../package.json"

# Compile the files
compiler = new Compiler(src: "./src", dest: "./app")
gulp.task "compileSettings", ->
  gulp.src("./src/settings.json").pipe(gulp.dest("./app"))
gulp.task "compileScripts", -> compiler.compileScripts()
gulp.task "compileStyles", -> compiler.compileStyles()
gulp.task "compileMarkup", -> compiler.compileMarkup()
gulp.task "compile", [
  "compileSettings"
  "compileScripts"
  "compileStyles"
  "compileMarkup"
]

# Nw tasks
NW_PACKAGE =
  "name": pkg.name
  "version": pkg.version
  "main": "index.html"
  "no-edit-menu": true
  "window":
    # "frame": false
    "toolbar": false
    "transparent": true
    "title": "Gitbutler"
    "min_width": 650
    "width": 650
    "height": 800
    "position": "center"
    "as_desktop": true
  "dependencies":
    "supershell": "0.1.6"

gulp.task "buildPackage", ->
  misc.writer(filename: "package.json", data: NW_PACKAGE, filter: misc.json())
    .pipe(gulp.dest("./app/"))

# General
vendors = new Vendors()
gulp.task "buildBower", -> vendors.buildBower()
gulp.task "buildVendors", -> vendors.buildVendors()
gulp.task "vendors", ["buildVendors", "buildBower"]

gulp.task "build", ["buildPackage", "compile", "vendors"]

gulp.task "watch", ["build"], ->
  for task, patterns of compiler.watchList
    for pattern in patterns
      gulp.watch pattern, [task]

# Install
installer = new Installer(name: "Gitbutler")
gulp.task "buildApp", ["build"], -> installer.buildApp()
gulp.task "installMac", ["buildApp"], -> installer.installMac()

gulp.task "default", ["watch"]

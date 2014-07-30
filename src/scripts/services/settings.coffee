
path = require "path"
fs = require "fs"
{EventEmitter} = require "events"
Observable = require "../tools/observable"

class SettingsService

  @$inject = ["$rootScope"]

  constructor: (@scope) ->
    @_folder = path.join(process.env.HOME, ".gitbutler")
    @_jsonFile = path.join(@_folder, "settings.json")
    unless fs.existsSync(@_folder)
      fs.mkdirSync(@_folder)
    if fs.existsSync(@_jsonFile)
      @_createCfg(@_jsonFile)
    else
      @_createCfg(path.resolve("settings.json"))

  _createCfg: (file) ->
    @cfg = new Observable(JSON.parse(fs.readFileSync(file)))
    @cfg.on("refresh", (key) =>
      @scope.$emit("refresh")
      fs.writeFile(@_jsonFile, JSON.stringify(@cfg.serialize(), null, 2))
    )

module.exports = SettingsService
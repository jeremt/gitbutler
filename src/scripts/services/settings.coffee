
path = require "path"
fs = require "fs"
{EventEmitter} = require("events")

class SettingsService extends EventEmitter

    root = "/Users/jeremietaboada/.gitbutler"

    constructor: ->
        if fs.existsSync(root) is false
            fs.mkdirSync(root)
            str = fs.readFileSync(path.resolve("settings.json"))
        else
            str = fs.readFileSync(path.join(root, "settings.json"))
        @data = JSON.parse(str)

    set: (name, value) ->
        @data[name] = value
        @save()

    add: (name, value) ->
        @data[name]?.push?(value)
        @save()

    remove: (name, index) ->
        @data[name]?.splice?(index, 1)
        @save()

    get: (name) ->
        @data[name]

    save: ->
        fs.writeFile(path.join(root, "settings.json"), JSON.stringify(@data, null, 2))
        @

exports.Settings = SettingsService
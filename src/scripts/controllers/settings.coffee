
class SettingsCtrl

  @$inject = ["$scope", "SettingsService"]

  constructor: (@scope, @settings) ->
    # scope.cfg = @settings.cfg
    console.log("settings: ", @settings.cfg.localRefresh)
    console.log("settings: ", @settings.cfg.remoteRefresh)
    console.log("settings: ", @settings.cfg.mergeMode)

    console.log("settings: ", @settings.cfg.theme)
    console.log("settings: ", @settings.cfg.menuStyle)

module.exports = SettingsCtrl
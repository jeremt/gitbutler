
class SettingsCtrl

  @$inject = ["$scope", "SettingsService"]

  THEMES = ["default"]
  MENU_STYLES = ["icon", "text"]

  constructor: (@scope, @settings) ->

    scope.themes = Object.create(THEMES)
    scope.theme = scope.themes[scope.themes.indexOf(@settings.cfg.theme)]

    scope.menuStyles = Object.create(MENU_STYLES)
    scope.menuStyle = scope.menuStyles[scope.menuStyles.indexOf(@settings.cfg.menuStyle)]

  update: (name, value) ->
    @settings.cfg[name] = value

module.exports = SettingsCtrl
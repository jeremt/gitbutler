
path = require "path"

class SettingsCtrl

  @$inject = ["$scope", "SettingsService", "GitService", "ToolboxService"]

  THEMES = ["default"]
  MENU_STYLES = ["icon", "text"]
  PULL_MODES = ["rebase", "pull"]

  constructor: (@scope, @settings, @git, @toolbox) ->

    @scope.themes = Object.create(THEMES)
    @scope.theme = @scope.themes[@scope.themes.indexOf(@settings.cfg.theme)]

    @scope.menuStyles = Object.create(MENU_STYLES)
    @scope.menuStyle = @scope.menuStyles[@scope.menuStyles.indexOf(@settings.cfg.menuStyle)]

    @scope.pullModes = Object.create(PULL_MODES)
    @scope.pullMode = @scope.pullModes[@scope.pullModes.indexOf(@settings.cfg.pullMode)]

  update: (name, value) ->
    @settings.cfg[name] = value

  openSettings: ->
    @settings.open()

  openGitignore: ->
    @toolbox.editFile(path.join(@git.ctx.scope.folder, ".gitignore"))

module.exports = SettingsCtrl
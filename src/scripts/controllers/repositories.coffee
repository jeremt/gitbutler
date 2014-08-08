
path = require "path"

class RepositoriesCtrl

  @$inject = [
    "$scope"
    "ToolboxService"
    "GitService"
    "SettingsService"
    "AlertService"
    "OverlayService"
  ]

  constructor: (@scope, @toolbox, @git, @settings, @alert, @overlay) ->
    @scope.data = @settings.cfg.repositories.serialize()
    @settings.on("refresh", =>
      @scope.data = @settings.cfg.repositories.serialize()
      if @scope.$$phase is null
        @scope.$apply()
    )
    current = @settings.getCurrentRepository()
    if current
      @git.ctx.exec("open", current.folder)

  open: ->
    @toolbox.openFile(((f) => @_add(f)), folder: true)

  clone: ->
    @overlay.emit("show", "clone-repository", "Clone a repository")

  create: ->
    @overlay.emit("show", "create-repository", "Create a repository")

  _hasRepository: (alias) ->
    @settings.cfg.repositories.list.find((r) -> r.alias is alias) is false

  _add: (folder) ->
    return unless folder
    alias = path.basename(folder)
    if @_hasRepository(alias)
      @git.ctx.exec("open", folder)
        .on("success", =>
          @settings.addRepository(alias: alias, folder: folder)
        )
    else
      @alert.error "Repository #{alias} already exists..."

module.exports = RepositoriesCtrl
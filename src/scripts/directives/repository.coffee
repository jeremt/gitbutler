
module.exports = [

  "SettingsService"
  "GitService"
  "AlertService"

  (settings, git, alert) ->
    restrict: "E"
    replace: true
    template: """
    <div ng-dblclick="select()"
      class="gb-repository sk-box"
      ng-class="{selected: isCurrent()}">
      <span class="sk-right">
        <span ng-click="remove()" class="sk-icon icon-circle-cross"></span>
      </span>
      <span class="alias">{{alias}}</span>
    </div>
    """
    scope:
      alias: "@"
    link: (scope) ->

      scope.select = ->
        settings.cfg.repositories.current = scope.getIndex()
        current = settings.getCurrentRepository()
        git.ctx.scope.folder = current.folder
        git.ctx.exec("open", current.folder)

      scope.getIndex = ->
        settings.cfg.repositories.list.findIndex((repo) ->
          repo.alias is scope.alias
        )

      scope.isCurrent = ->
        scope.getIndex() is settings.cfg.repositories.current

      scope.remove = ->
        if window.confirm "Are you sure?"
          settings.cfg.repositories.list.splice(scope.getIndex(), 1)
          settings.cfg.repositories.current = 0

]

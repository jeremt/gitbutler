
path = require "path"

module.exports = (git, toolbox) ->
    restrict: "E"
    replace: true
    scope:
      label: "@"
      file: "@"
      type: "@"
    template: """
    <div ng-dblclick="updateIndex()" class="gb-file-status sk-box">
      <span class="sk-right sk-small">
        <span class="status">{{label}}</span>
        <span class="sk-icon icon-folder" ng-click="open()"></span>
        <span class="sk-icon icon-paper" ng-click="edit()"></span>
        <span class="sk-icon icon-paper-stack" ng-click="diff()"></span>
      </span>
      <span class="name">{{file}}</span>
    </div>
    """
    link: (scope) ->
      scope.open = ->
        toolbox.showFile(path.join(git.ctx.scope.folder, scope.file))
      scope.edit = ->
        toolbox.editFile(path.join(git.ctx.scope.folder, scope.file))
      scope.diff = ->
        window.alert("Diff #{scope.file}!")
      scope.updateIndex = ->
        if scope.type in ["unstaged", "conflicted"]
          git.ctx.exec('stage', scope.file)
        else
          git.ctx.exec('unstage', scope.file)

module.exports.$inject = ["GitService", "ToolboxService"]

path = require "path"

module.exports = (git, toolbox, overlay) ->
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
      <a title="open" class="sk-icon icon-folder" ng-click="open()"></a>
      <a title="edit" class="sk-icon icon-paper" ng-click="edit()"></a>
      <a title="show diff" class="sk-icon icon-paper-stack" ng-click="diff()"></a>
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
      git.getDiff(scope.file, scope.type in ["unstaged", "conflicted"])
      overlay.emit("show", "file-diff", scope.file)
    scope.updateIndex = ->
      if scope.type in ["unstaged", "conflicted"]
        git.ctx.exec('stage', scope.file)
      else
        git.ctx.exec('unstage', scope.file)

module.exports.$inject = [
  "GitService"
  "ToolboxService"
  "OverlayService"
]
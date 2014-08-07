module.exports = ->
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
        window.alert("Open #{scope.file}!")
      scope.edit = ->
        window.alert("Edit #{scope.file}!")
      scope.diff = ->
        window.alert("Diff #{scope.file}!")
      scope.updateIndex = ->
        if scope.type in ["unstaged", "conflicted"]
          window.alert("Add #{scope.file}")
        else
          window.alert("Reset #{scope.file}")

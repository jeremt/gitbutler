module.exports = ->
    restrict: "E"
    replace: true
    scope:
      status: "@"
      name: "@"
      type: "@"
    template: """
    <div ng-dblclick="updateIndex()" class="gb-file-status sk-box">
      <span class="sk-right sk-small">
        <span class="status">{{status}}</span>
        <span class="sk-icon icon-folder" ng-click="open()"></span>
        <span class="sk-icon icon-paper" ng-click="edit()"></span>
        <span class="sk-icon icon-paper-stack" ng-click="diff()"></span>
      </span>
      <span class="name">{{name}}</span>
    </div>
    """
    link: (scope) ->
      scope.open = ->
        window.alert("Open #{scope.name}!")
      scope.edit = ->
        window.alert("Edit #{scope.name}!")
      scope.diff = ->
        window.alert("Diff #{scope.name}!")
      scope.updateIndex = ->
        if scope.type in ["unstaged", "conflicted"]
          window.alert("Add #{scope.name}")
        else
          window.alert("Reset #{scope.name}")

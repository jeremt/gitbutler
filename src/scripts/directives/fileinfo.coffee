module.exports = ->
    restrict: "E"
    replace: true
    scope:
      status: "@"
      name: "@"
    template: """
    <div class="file-info sk-box">
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
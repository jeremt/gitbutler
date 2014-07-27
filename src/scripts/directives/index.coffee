
module.exports = (ngModule) ->

  ngModule.directive "gbDiff", ->
    restrict: "E"
    replace: true
    template: """
    <div class="diff">Git diff!</div>
    """
    link: ->
      console.log "display diff..."

  ngModule.directive "gbFileInfo", ->
    restrict: "E"
    replace: true
    scope:
      status: "@"
      name: "@"
    template: """
    <span class="file-info" ng-click="openDiff()">
      <span class="right small">
        <span class="status">{{status}}</span>
        <a ng-click="open()">open</a>
        <a ng-click="edit()">edit</a>
        <a ng-click="diff()">diff</a>
      </span>
      <span class="name">{{name}}</span>
    </span>
    """
    link: (scope) ->
      scope.open = ->
        window.alert("Open #{scope.name}!")
      scope.edit = ->
        window.alert("Edit #{scope.name}!")
      scope.diff = ->
        window.alert("Diff #{scope.name}!")

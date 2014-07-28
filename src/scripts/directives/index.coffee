
module.exports = (ngModule) ->

  #
  # Diff
  #

  ngModule.directive "gbDiff", ->
    restrict: "E"
    replace: true
    template: """
    <div class="diff">Git diff!</div>
    """
    link: ->
      console.log "display diff..."

  #
  # File info
  #

  ngModule.directive "gbFileInfo", ->
    restrict: "E"
    replace: true
    scope:
      status: "@"
      name: "@"
    template: """
    <span class="file-info">
      <span class="sk-right sk-small">
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

  #
  # Branch
  #

  ngModule.directive "gbBranch", ->
    restrict: "E"
    replace: true
    template: """
    <div class="gb-branch">
      <span class="name">{{name}}</span>
      <span class="sk-right sk-small">
        X
      </span>
    </div>
    """
    scope:
      name: "@"

  #
  # Commit
  #

  ngModule.directive "gbCommit", ->
    restrict: "E"
    replace: true
    template: """
    <div class="gb-commit">
      <a class="sk-small sk-right">{{hash}}</a>
      <div class="message">{{message}}</div>
      <footer class="sk-small">
        <span class="author">{{author}}</span>
        <span class="date">{{date}}</span>
      </footer>
    </div>
    """
    scope:
      message: "@"
      date: "@"
      author: "@"
      hash: "@"
    link: (scope) ->


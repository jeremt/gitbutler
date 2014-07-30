
module.exports = (ngModule) ->

  #
  # Repository
  #

  ngModule.directive "gbRepository", [

    "SettingsService"
    "$rootScope"

    (settings, rootScope) ->
      restrict: "E"
      replace: true
      template: """
      <div
        ng-click="select()"
        class="gb-repository sk-box"
        ng-class="{selected: current}">
        <span class="sk-right">
          <span ng-click="remove()" class="sk-icon icon-circle-cross"></span>
        </span>
        <span class="alias">{{alias}}</span>
      </div>
      """
      scope:
        alias: "@"
        index: "="
      link: (scope) ->
        scope.current = scope.index is settings.cfg.repositories.current
        scope.select = ->
          settings.cfg.repositories.current = scope.index
        scope.remove = ->
          settings.cfg.repositories.list.splice(settings.cfg.repositories.current, 1)
        rootScope.$on "refresh", ->
          scope.current = scope.index is settings.cfg.repositories.current

    ]

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
        <span class="sk-icon icon-folder" ng-click="open()"></span>
        <span class="sk-icon icon-paper" ng-click="edit()"></span>
        <span class="sk-icon icon-paper-stack" ng-click="diff()"></span>
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
    <div class="sk-box">
      <span class="name">{{name}}</span>
      <span class="sk-right">
        <span class="sk-icon icon-cloud-upload"></span>
        <span class="sk-icon icon-cloud-download"></span>
        <span class="sk-icon icon-circle-cross"></span>
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
    <div class="gb-commit sk-box">
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

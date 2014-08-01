
module.exports = [

  "GitService"
  "AlertService"

  (git, alert) ->
    restrict: "E"
    replace: true
    template: """
    <div class="sk-box"
      ng-class="{selected: isCurrent()}"
      ng-click="select()">
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
    link: (scope) ->
      scope.select = ->
        git.ctx.exec("checkout", scope.name)
      scope.isCurrent = ->
        scope.name is git.ctx.scope.branches.current
]
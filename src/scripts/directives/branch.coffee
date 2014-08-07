
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
        <span ng-click="push()" class="sk-icon icon-cloud-upload"></span>
        <span ng-click="pull()" class="sk-icon icon-cloud-download"></span>
        <span ng-click="remove()" class="sk-icon icon-circle-cross"></span>
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
      scope.push = ->
        window.alert("push origin #{scope.name}")
      scope.pull = ->
        window.alert("pull --rebase origin #{scope.name}")
      scope.remove = ->
        if window.confirm("Are you sure?")
          window.alert("branch -D #{scope.name}")
]
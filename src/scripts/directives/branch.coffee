
module.exports = [

  "GitService"
  "AlertService"

  (git, alert) ->
    restrict: "E"
    replace: true
    template: """
    <div class="sk-box"
      ng-class="{selected: isCurrent()}"
      ng-dblclick="select()">
      <span class="name">{{name}}</span>
      <span class="sk-right">
        <span ng-show="isCurrent()">
          <span class="sk-small">{{toPull}}</span>
          <span ng-click="rebase()" class="sk-icon icon-cloud-download"></span>
          <span class="sk-small">{{toPush}}</span>
          <span ng-click="push()" class="sk-icon icon-cloud-upload"></span>
        </span>
        <span ng-click="remove()" class="sk-icon icon-circle-cross"></span>
      </span>
    </div>
    """
    scope:
      name: "@"
    link: (scope) ->
      scope.toPull = 0
      scope.toPush = 0
      git.ctx.on("refresh", ->
        scope.toPull = git.ctx.scope.commits.remote.length
        scope.toPush = git.ctx.scope.commits.local.length
      )
      scope.select = ->
        git.ctx.exec("checkout", scope.name)
      scope.isCurrent = ->
        scope.name is git.ctx.scope.branches.current
      scope.push = ->
        git.ctx.exec("push").on("success", (output) ->
          alert.success("Push succeed: #{output}")
        )
      scope.rebase = ->
        git.ctx.exec("rebase").on("success", (output) ->
          alert.success("Rebase succeed: #{output}")
        )
      scope.remove = ->
        if window.confirm("Are you sure?")
          window.alert("branch -D #{scope.name}")
]
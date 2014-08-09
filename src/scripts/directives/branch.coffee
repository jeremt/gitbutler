
module.exports = [

  "GitService"
  "AlertService"
  "SettingsService"

  (git, alert, settings) ->
    restrict: "E"
    replace: true
    template: """
    <div class="sk-box gb-branch"
      ng-class="{selected: isSelected(), used: isUsed()}"
      ng-click="use()"
      ng-dblclick="select()">
      <span class="name">{{name}}</span>
      <span class="sk-right">
        <span ng-show="isSelected()">
          <span ng-show="hasUsed()">
            <a ng-click="rebase($event)">rebase</a>
            <a ng-click="merge($event)">merge</a>
          </span>
          <span class="sk-small">{{toPull}}</span>
          <span ng-click="pull()" class="sk-icon icon-cloud-download"></span>
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

      scope.isSelected = -> scope.name is git.ctx.scope.branches.current
      scope.isUsed = -> scope.name is git.used

      scope.hasUsed = -> git.used?

      scope.use = ->
        if scope.isSelected()
          git.used = null
        else
          git.used = scope.name
      scope.select = ->
        git.used = null
        git.ctx.exec("checkout", scope.name)

      scope.rebase = (event) ->
        alert.info("rebasing branch '#{git.used}'...")
        git.ctx.exec("rebase", git.used).on("success", (output) ->
          alert.success(output)
        )
      scope.merge = (event) ->
        alert.info("merging branch '#{git.used}'...")
        git.ctx.exec("merge", git.used).on("success", (output) ->
          alert.success(output)
        )

      scope.push = ->
        alert.info("pushing data to remote branch '#{scope.name}'...")
        git.ctx.exec("push").on("success", (output) ->
          alert.success(output)
        )
      scope.pull = ->
        alert.info("pulling data from remote branch '#{scope.name}'...")
        git.ctx.exec("pull", settings.cfg.pullMode is 'rebase')
          .on("success", (output) ->
            alert.success(output)
          )
      scope.remove = ->
        if window.confirm("Are you sure?")
          alert.info("removing branch '#{scope.name}'...")
          git.ctx.exec("removeBranch", scope.name).on("success", =>
            alert.success("branch '#{scope.name}' successfuly removed!")
          )

]
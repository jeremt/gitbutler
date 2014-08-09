
class BranchesCtrl

  @$inject = ["$scope", "GitService", "AlertService"]

  constructor: (@scope, @git, @alert) ->
    @scope.data = {}
    @scope.newBranch = name: ""
    @git.ctx.on("refresh", =>
      @scope.data =
        list: @git.getBranches()
    )

  create: (name) ->
    @alert.info("create branch '#{name}'...")
    @git.ctx.exec("branch", name).on("success", =>
      @alert.success("branch '#{name}' successfuly created!")
      @scope.newBranch.name = ""
    )

module.exports = BranchesCtrl
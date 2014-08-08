
class BranchesCtrl

  @$inject = ["$scope", "GitService", "AlertService"]

  constructor: (@scope, @git, @alert) ->
    @scope.data = {}
    @git.ctx.on("refresh", =>
      @scope.data =
        list: @git.getBranches()
    )

  create: (name) ->
    @git.ctx.exec("branch", name).on("success", =>
      @alert.success("Branch '#{name}' successfuly created!")
    )

module.exports = BranchesCtrl

class BranchesCtrl

  @$inject = ["$scope", "GitService"]

  constructor: (@scope, @git) ->
    @scope.data = {}
    @git.ctx.on("refresh", =>
      @scope.data =
        list: @git.getBranches()
    )

  create: ->
    window.alert("create #{@scope.branch.name}")

    # @scope.branchList.push(@scope.branch.name)

module.exports = BranchesCtrl
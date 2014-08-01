
class HistoryCtrl

  @$inject = ["$scope", "GitService"]

  constructor: (@scope, @git) ->
    @scope.commits =
      remote: []
      local: []
      common: []
    @git.ctx.on("refresh", =>
      @scope.commits = @git.ctx.scope.commits
      if @scope.$$phase is null
        @scope.$apply()
    )

module.exports = HistoryCtrl
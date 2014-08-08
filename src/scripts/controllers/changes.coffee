
class ChangesCtrl

  @$inject = ["$scope", "GitService"]

  constructor: (@scope, @git) ->
    @scope.rebasing = false
    @scope.commit = message: ""
    @git.ctx.on("refresh", =>
      @scope.rebasing = @git.ctx.scope.rebasing
      @scope.files = @git.ctx.scope.files
    )

  isClean: ->
    @scope.files?.staged?.length is 0 and
    @scope.files?.unstaged?.length is 0 and
    @scope.files?.conflicted?.length is 0

  abort: ->
    @git.ctx.exec("rebase", "abort").on("success", (output) =>
      @alert.success(output)
    )

  skip: ->
    @git.ctx.exec("rebase", "skip").on("success", (output) =>
      @alert.success(output)
    )

  continue: ->
    @git.ctx.exec("rebase", "continue").on("success", (output) =>
      @alert.success(output)
    )

  commit: (message) ->
    @git.ctx.exec("commit", @scope.commit.message).on("success", (output) =>
      @scope.commit.message = ""
      @alert.success(output)
    )

module.exports = ChangesCtrl

class ChangesCtrl

  @$inject = ["$scope", "GitService"]

  constructor: (@scope, @git) ->
    @scope.commit = message: ""
    @git.ctx.on("refresh", =>
      @scope.files = @git.ctx.scope.files
    )

    # conflicts:
    # ---------

    # D - D both deleted
    # A - U added by us
    # U - D deleted by them
    # U - A added by them
    # D - U deleted by us
    # A - A both added
    # U - U both modified

    # staged
    # ---------
    # . -  [MD] not updated
    # M - [ MD] modified
    # A - [ MD] added
    # D - [ M] deleted
    # R - [ MD] renamed
    # C - [ MD] copied

    # unstaged
    # ---------
    # [MARC] - . same changes
    # [ MARC] - M modified
    # [ MARC] - D deleted
    # ? - ? untracked

  isClean: ->
    @scope.files?.staged?.length is 0 and
    @scope.files?.unstaged?.length is 0 and
    @scope.files?.conflicted?.length is 0

  commit: (message) ->
    @git.ctx.exec("commit", @scope.commit.message).on("success", =>
      @scope.commit.message = ""
    )

module.exports = ChangesCtrl
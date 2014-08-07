
class ChangesCtrl

  @$inject = ["$scope", "GitService"]

  constructor: (@scope, @git) ->
    @scope.commit = message: ""
    @scope.files = 
      staged: []
      unstaged: []
      conflicted: []

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

  commit: (message) ->
    window.alert("Commit #{@scope.commit.message}")
    @scope.commit.message = ""

module.exports = ChangesCtrl
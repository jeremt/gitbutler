
class ChangesCtrl

  @$inject = ["$scope"]

  constructor: (@scope) ->
    @scope.commit = message: ""
    @scope.files = 
      staged: [
        {name: "app/index.coffee", status: "modified", selected: true}
        {name: "app/gulp/index.coffee", status: "added", selected: false}
        {name: "app/services/index.coffee",    status: "untracked", selected: false}
      ]
      unstaged: [
        {name: "app/services/git.coffee",    status: "modified", selected: false}
        {name: "app/controllers/", status: "untracked", selected: false}
      ]
      conflicted: [
      ]

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
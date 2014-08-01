
class ChangesCtrl

  @$inject = ["$scope"]

  constructor: (@scope) ->
    @scope.commit = message: ""
    @scope.files = [
      {name: "app/index.coffee", status: "modified", selected: true}
      {name: "app/controllers/", status: "untracked", selected: false}
      {name: "app/gulp/index.coffee", status: "added", selected: false}
      {name: "app/services/",    status: "untracked", selected: false}
    ]

  commit: (message) ->
    window.alert("Commit #{@scope.commit.message}")
    @scope.commit.message = ""

module.exports = ChangesCtrl
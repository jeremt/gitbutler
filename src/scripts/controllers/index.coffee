
module.exports = (ngModule) ->

  #
  # Repositories
  #

  ngModule.controller "RepositoriesCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->
      @scope.current = 0
      @scope.repositories = [
        {name: "craftboy"}
        {name: "artwork"}
        {name: "director"}
      ]

  #
  # Changes
  #

  ngModule.controller "ChangesCtrl", class

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

  #
  # History
  #

  ngModule.controller "HistoryCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->
      @scope.commits = [
        {message: "Improve API", date: "6 days ago", author: "Jeremie", hash: "41ce3d51a049ae24274e87be795a70bb1953b3f1"}
        {message: "Update build system", date: "8 days ago", author: "Jeremie", hash: "41ce3d51a049ae24274e87be795a70bb1953b3f1"}
        {message: "Clean/Refactore", date: "12 days ago", author: "Jeremie", hash: "41ce3d51a049ae24274e87be795a70bb1953b3f1"}
      ]

  #
  # Branches
  #

  ngModule.controller "BranchesCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->
      @scope.branch = name: ""
      @scope.branchList = [
        {name: "master"}
        {name: "develop"}
        {name: "feature/test"}
      ]

    create: ->
      @scope.branchList.push({name: @scope.branch.name})
      @scope.branch.name = ""

  #
  # Settings
  #

  ngModule.controller "SettingsCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->


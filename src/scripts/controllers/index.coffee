
module.exports = (ngModule) ->

  ngModule.controller "RepositoriesCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->
      @scope.current = 0
      @scope.repositories = [
        {name: "craftboy"}
        {name: "artwork"}
        {name: "director"}
      ]

  ngModule.controller "ChangesCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->
      @scope.files = [
        {name: "app/index.coffee", status: "modified", selected: true}
        {name: "app/controllers/", status: "untracked", selected: false}
        {name: "app/gulp/index.coffee", status: "added", selected: false}
        {name: "app/services/",    status: "untracked", selected: false}
      ]

    commit: (message) ->
      window.alert("Commit #{message}")

  ngModule.controller "HistoryCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->
      @scope.commits = [
        {message: "Improve API", date: "6 days ago", author: "Jeremie", hash: "41ce3d51a049ae24274e87be795a70bb1953b3f1"}
        {message: "Update build system", date: "8 days ago", author: "Jeremie", hash: "41ce3d51a049ae24274e87be795a70bb1953b3f1"}
        {message: "Clean/Refactore", date: "12 days ago", author: "Jeremie", hash: "41ce3d51a049ae24274e87be795a70bb1953b3f1"}
      ]

  ngModule.controller "BranchesCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->
      @scope.name = 'myfeature'
      @scope.branchList = [
        {name: "master"}
        {name: "develop"}
        {name: "feature/test"}
      ]

    create: ->
      @scope.branchList.push({name: @scope.name})


  ngModule.controller "SettingsCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->


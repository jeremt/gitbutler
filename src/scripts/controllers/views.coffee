
module.exports = (ngModule) ->

  ngModule.controller "ChangesCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->
      @scope.files = [
        {name: "app/index.coffee", status: "modified", selected: true}
        {name: "app/controllers/", status: "untracked", selected: false}
        {name: "app/controllers/", status: "untracked", selected: false}
        {name: "app/services/",    status: "untracked", selected: false}
      ]

    commit: (message) ->
      window.alert("Commit #{message}")

  ngModule.controller "HistoryCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->

  ngModule.controller "BranchesCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->

  ngModule.controller "SettingsCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->



module.exports = (ngModule) ->

  ngModule.controller "CloneCtrl", require("./clone")
  ngModule.controller "RepositoriesCtrl", require("./repositories")
  ngModule.controller "ChangesCtrl", require("./changes")
  ngModule.controller "HistoryCtrl", require("./history")
  ngModule.controller "BranchesCtrl", require("./branches")
  ngModule.controller "SettingsCtrl", require("./settings")

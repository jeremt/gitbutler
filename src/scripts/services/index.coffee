
module.exports = (ngModule) ->

  ngModule.service "GitService", require("./git")
  ngModule.service "ToolboxService", require("./toolbox")
  ngModule.service "SettingsService", require("./settings")
  ngModule.service "AlertService", require("./alert")

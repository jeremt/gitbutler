
module.exports = (ngModule) ->

  ngModule.directive "gbRepository", require("./repository")
  ngModule.directive "gbDiff", require("./diff")
  ngModule.directive "gbFileStatus", require("./filestatus")
  ngModule.directive "gbBranch", require("./branch")
  ngModule.directive "gbCommit", require("./commit")
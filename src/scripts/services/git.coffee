
{EventEmitter} = require "events"
sh = require "supershell"
fs = require "fs"

class GitService extends EventEmitter

  @$inject = ["SettingsService", "AlertService"]

  constructor: (@settings, @alert) ->
    @ctx = sh.git
    @ctx.refresh(@settings.cfg.localRefresh, [
      "branches"
      "files"
    ])
    @ctx.refresh(@settings.cfg.remoteRefresh, [
      "rebasing"
      "resolve"
      "commits"
    ])
    @ctx.on("fail", (message) =>
      @alert.error(message)
    )

  getBranches: ->
    list = @ctx.scope.branches.local

    # Add remote branches if not already exist locally
    for branch in @ctx.scope.branches.remote
      unless branch in list
        list.push(branch)

    # Move the current branch to the top of the list
    index = list.indexOf(@ctx.scope.branches.current)
    list.splice(index, 1).concat(list)

module.exports = GitService
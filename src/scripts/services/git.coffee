
{EventEmitter} = require "events"
sh = require "supershell"

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
    for branch in @ctx.scope.branches.remote
      unless branch in list
        list.push(branch)
    list

module.exports = GitService
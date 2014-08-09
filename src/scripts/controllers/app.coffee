
{splitQuotes} = require "../tools/misc"

class AppCtrl

  @$inject = [
    "$scope"
    "GitService"
    "AlertService"
  ]

  constructor: (@scope, @git, @alert) ->
    @scope.commandMode = false
    @scope.command = line: ""
    @scope.commands = []
    @_handleEvents()
    @addCommand("stage file", "Stage the given file for the next commit.")
    @addCommand("unstage file", "Unstage the given file of the next commit.")
    @addCommand("stageAll", "Stage all files for the next commit.")
    @addCommand("unstageAll", "Unstage all files of the next commit.")
    @addCommand("checkout branch/file/commit", "Reset changes for a file, or set it as the current one for a branch or a commit.")
    @addCommand("commit message", "Commit with the given message.")
    @addCommand("merge branch", "Merge the given branch on the current one.")
    @addCommand("rebase branch", "Same as merge in 'rebase' mode.")
    @addCommand("fetch", "Update the local information from remote.")
    @addCommand("push", "Push commits to the remote.")
    @addCommand("pull", "Pull commits from the remote.")

  runCommand: (line) ->
    if @scope.command.line.length >= 1
      cmd = splitQuotes(@scope.command.line)
      @git.ctx.exec.apply(@git.ctx, cmd).on("success", =>
        @alert.success("Command `#{@scope.command.line}` succeed.")
        @scope.command.line = ""
      )
    else
      @alert.error("The command should be at least 1 character!")

  addCommand: (name, description) ->
    @scope.commands.push(name: name, description: description)

  _handleEvents: ->
    window.jwerty.key("0+cmd", =>
      @scope.commandMode = not @scope.commandMode
    )

module.exports = AppCtrl
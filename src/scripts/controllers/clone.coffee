
class CloneCtrl

  @$inject = ["$scope", "ToolboxService"]

  constructor: (@scope, @toolbox) ->
    @scope.repo =
      folder: ""
      url: ""

  openFolder: ->
    @toolbox.openFile(((folder) =>
      @scope.repo.folder = folder
    ), folder: true)

  run: ->
    window.alert("Clone repo")

module.exports = CloneCtrl
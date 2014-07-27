
module.exports = (ngModule) ->

  ngModule.controller "AppCtrl", class

    @$inject = ["$scope"]

    constructor: (@scope) ->
      console.log "App created!"

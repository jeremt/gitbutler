
class AlertService

  constructor: ->
    @_previousMessage = null

  info: (message, {btn, btnFn, force} = {}) ->
    @_createPopup(message, btn, btnFn, force, "Info")

  warning: (message, {btn, btnFn, force} = {}) ->
    @_createPopup(message, btn, btnFn, force, "Warning")

  error: (message, {btn, btnFn, force} = {}) ->
    @_createPopup(message, btn, btnFn, force, "Error")

  _createPopup: (message, btn, btnFn, force, label) ->
    if @_previousMessage isnt message or force
      window.alert("#{label}: #{message}")
      @_previousMessage = message



module.exports = AlertService

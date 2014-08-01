
{EventEmitter} = require "events"

class AlertService extends EventEmitter

  constructor: ->
    @_previousMessage = null

  info: (message, {btn, btnFn, force} = {}) ->
    @_createPopup(message, btn, btnFn, force, "info")

  success: (message, {btn, btnFn, force} = {}) ->
    @_createPopup(message, btn, btnFn, force, "success")

  error: (message, {btn, btnFn, force} = {}) ->
    @_createPopup(message, btn, btnFn, force, "error")

  _createPopup: (message, btn, btnFn, force, label) ->
    if @_previousMessage isnt message or force
      # window.alert("#{label}: #{message}")
      @emit("message", label, message)
      @_previousMessage = message



module.exports = AlertService

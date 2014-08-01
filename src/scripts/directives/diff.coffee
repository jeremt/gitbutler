
module.exports = ->
  restrict: "E"
  replace: true
  template: """
  <div class="diff">Git diff!</div>
  """
  link: ->
    console.log "display diff..."

{EventEmitter} = require "events"

class GitService extends EventEmitter

  constructor: ->
    console.log "Create git..."

module.exports = GitService
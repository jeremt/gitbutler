
{EventEmitter} = require "events"
{mixOf}        = require "./misc"

# Represent an simple JS object. It also calls the `udpate` event whenever
# one value of the object is modified (and it works recursively).
#
# @example
#   pkg = new Observable(require("./package"))
#
#   # the following displays:
#   # - refresh angular
#   # - refresh name
#
#   pkg.on("refresh", (key) -> console.log "refresh #{key}")
#
#   pkg.dependencies.angular = "*"
#   pkg.name = "myawesomepackage"
#
class Observable extends EventEmitter

  # The event key which is emitted when the object is refreshed. If "refresh"
  # is already use for other purpose, you can easily change it that way:
  #   Observable.EVENT_KEY = "refreshObservable"
  #
  @EVENT_KEY = "refresh"

  # Create an observable instance.
  #
  # @param {Object} _values some values to deserialize within the observable
  # @param {Observable} _parent the parent of this observable (null when root)
  #
  constructor: (@_values = {}, @_parent = null) ->
    @deserialize(@_values)

  # Register the given property into this observable.
  #
  # @param key the key of the property
  # @param value the value of the property
  # @api private
  #
  _addProperty: (key, value) ->
    if value instanceof Observable
      value._parent = @
      @[key] = value
    else if value instanceof Array
      @[key] = new ObservableArray(value, @)
    else if value instanceof Object
      @[key] = new Observable(value, @)
    else
      @_values[key] = value
      @__defineSetter__(key, (v) =>
        @_values[key] = v
        @broadcast(Observable.EVENT_KEY)
      )
      @__defineGetter__(key, => @_values[key])

  broadcast: (evt, args...) ->
    current = @
    while current
      current.emit(Observable.EVENT_KEY, args...)
      current = current._parent

  # Deserialize the given `data` into this observable.
  #
  # @param {Object} data the data to deserialize
  #
  deserialize: (data) ->
    for key, value of @_values
      @_addProperty(key, value)

  # Serialize the values of this configurable into a JSON-serializable
  # javascript object.
  #
  # @return {Object} the serialized object
  #
  serialize: ->
    result = {}
    for key, value of @_values
      result[key] = value
    result

  # Make a method observable means that the refrsh event will be automatically
  # triggered directly after a call of this method.
  #
  # @param {Type} cls the class which has the method
  # @param {String} name the name of the method
  # @param {Any} instance the instance which has the method (this by default)
  #
  observe: (cls, name, instance) ->
    @[name] = (args...) ->
      # TODO create new observables from args if neeeded
      r = cls::[name].apply(instance ? @, args)
      @broadcast(Observable.EVENT_KEY)
      return r

class ObservableArray extends Observable

  # Method which update the array
  METHODS = ["splice", "push", "pop", "shift", "unshift", "reverse", "sort"]

  constructor: (args, parent = null) ->
    Observable.call(@, {}, parent)
    @_array = args
    for name in METHODS
      @observe(Array, name, @_array)
    @__defineGetter__('length', -> @_array.length)

  # Patch because we cannot inherit from Array...
  at: (i) -> @_array[i]

  # Find into the array.
  find: (fn) ->
    for el in @_array
      if fn(el) then return el
    false

  # Find into the array.
  findIndex: (fn) ->
    for i in [0..@_array.length]
      if fn(@_array[i], i) then return i
    -1

module.exports = Observable

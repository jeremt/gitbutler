
module.exports =

  # Simple helper to handler multiple inheritance.
  #
  # @param [Object] base the class which will be extended
  # @param [Object...] mixins the list of all mixins to inherit from
  #
  mixOf: (base, mixins...) ->
    class Mixed extends base
    for mixin in mixins by -1 # earlier mixins override later ones
      for name, method of mixin::
        Mixed::[name] = method
    Mixed

module.exports = (ngModule) ->

  ngModule.filter "searchCommand", ->
    (items, search) ->
      unless search?.split?(' ')?
        return items
      name = search.split(' ')[0].toLowerCase()
      items.filter((element, index, array) ->
        return element.name.split(' ')[0].indexOf(name) is 0
      )
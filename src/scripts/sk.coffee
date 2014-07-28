
module.exports = (ngModule) ->

  #
  # Views
  #

  ngModule.directive "skViews", ->
    restrict: "E"
    transclude: true
    template: """
    <nav>
      <span
        ng-repeat="view in views"
        ng-click="select(view)"
        class="sk-icon {{view.icon}}"
        ng-class="{selected: view.selected}">
      </span>
    </nav>
    <div class="sk-container" ng-transclude></div>
    """
    controller: class

      @$inject = ["$scope"]

      constructor: (@scope) ->
        @scope.views = []
        @scope.select = (view) =>
          for current in @scope.views
            current.selected = false
          view.selected = true
        @_handleEvents()

      addView: (view) ->
        if @scope.views.length is 0
          @scope.select(view)
        @scope.views.push(view)

      selectIndex: (index) ->
        return unless 0 <= index < @scope.views.length
        @scope.$apply(=> @scope.select(@scope.views[index]))

      _handleEvents: ->
        window.jwerty.key("cmd+1", => @selectIndex(0))
        window.jwerty.key("cmd+2", => @selectIndex(1))
        window.jwerty.key("cmd+3", => @selectIndex(2))
        window.jwerty.key("cmd+4", => @selectIndex(3))
        window.jwerty.key("cmd+5", => @selectIndex(4))
        window.jwerty.key("cmd+6", => @selectIndex(5))
        window.jwerty.key("cmd+7", => @selectIndex(6))
        window.jwerty.key("cmd+8", => @selectIndex(7))
        window.jwerty.key("cmd+9", => @selectIndex(8))

  ngModule.directive "skView", ->
    require: "^skViews"
    replace: true
    restrict: "E"
    transclude: true
    scope:
      name: "@"
      icon: "@"
    template: """
    <div class="sk-view" ng-show="selected" ng-transclude></div>
    """
    link: (scope, el, attrs, parent) ->
      parent.addView(scope)

  #
  # Checklist
  #

  ngModule.directive "skChecklist", ->
    restrict: "E"
    replace: true
    transclude: true
    template: """
    <div class="sk-checklist" ng-transclude></div>
    """
    controller: class

      @$inject = ["$scope"]

      constructor: (@scope) ->
        @scope.current = 0
        @scope.items = []
        @_handleEvents()

      addItem: (item) ->
        if @scope.items.length is 0
          item.current = true
        @scope.items.push(item)

      _handleEvents: ->
        window.jwerty.key("up", =>
          @scope.$apply(=>
            @scope.items[@scope.current].current = false
            if @scope.current > 0
              @scope.current -= 1
            @scope.items[@scope.current].current = true
          )
        )
        window.jwerty.key("down", =>
          @scope.$apply(=>
            @scope.items[@scope.current].current = false
            if @scope.current < @scope.items.length - 1
              @scope.current += 1
            @scope.items[@scope.current].current = true
          )
        )
        window.jwerty.key("enter", =>
          @scope.$apply(=>
            item = @scope.items[@scope.current]
            item.selected = not item.selected
          )
        )

  ngModule.directive "skCheckitem", ->
    require: "^skChecklist"
    replace: true
    restrict: "E"
    transclude: true
    template: """
    <div class="sk-checkitem" ng-click="select()" ng-class="{current: current}">
      <input type="checkbox" ng-checked="selected">
      <span ng-transclude></span>
    </div>
    """
    scope:
      selected: '='
      current: '@'
    link: (scope, el, attrs, parent) ->
      scope.current = true
      parent.addItem(scope)
      scope.select = ->
        scope.selected = not scope.selected

  #
  # List
  #
  ngModule.directive "skList", ->
    restrict: "E"
    transclude: true
    template: """
    <div class="sk-list" ng-transclude></div>
    <button>Add</button>
    """

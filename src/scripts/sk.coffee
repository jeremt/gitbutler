
module.exports = (ngModule) ->

  #
  # Views
  #

  ngModule.directive "skViews", ->
    restrict: "E"
    transclude: true
    template: """
    <nav>

      <span ng-show="mode === 'icon'"
        ng-repeat="view in views"
        ng-click="select(view)"
        class="sk-icon {{view.icon}}"
        ng-class="{selected: view.selected}">
      </span>

      <button ng-show="mode === 'text'"
        ng-repeat="view in views"
        ng-click="select(view)"
        ng-class="{selected: view.selected}">
          {{view.name}}
      </button>

    </nav>
    <div class="sk-container" ng-transclude></div>
    """
    controller: class

      @$inject = ["$scope", "SettingsService"]

      constructor: (@scope, @settings) ->
        @settings.on("refresh", =>
          @scope.mode = @settings.cfg.menuStyle
        )

        @scope.views = []
        @scope.mode = @settings.cfg.menuStyle
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

  #
  # Alert
  #
  ngModule.directive "skAlert", [

    "AlertService" # TODO add this service in sk

    (alert) ->
      restrict: "E"
      template: """
      <div ng-click="hide()" ng-class="{selected: shown}" class="sk-alert {{label}}">
        {{message}}
      </div>
      """
      link: (scope) ->
        scope.shown ?= false
        alert.on("message", (label, message) ->
          scope.label = label
          scope.message = message
          scope.shown = true
          if scope.$$phase
            scope.$apply()
        )
        scope.hide = ->
          scope.shown = false
          alert.reset()

  ]

  ngModule.directive "skOverlay", [

    "OverlayService"

    (overlay) ->
      restrict: "E"
      template: """
      <div class="sk-overlay" ng-show="visible">
        <header>
          <div ng-click="hide()" class="close sk-right icon-cross"></div>
          <h2 class="sk-center">{{title}}</h2>
        </header>
        <div class="content" ng-transclude>
        </div>
      </div>
      """
      transclude: true
      scope:
        id: "@"
      link: (scope) ->
        scope.visible = false
        scope.hide = ->
          scope.visible = false
        overlay.on("show", (id, title) ->
          scope.visible = id is scope.id
          if title?
            scope.title = title
        )

  ]

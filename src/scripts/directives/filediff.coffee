
module.exports = [

  "GitService"

  (git) ->
    require: "^skOverlay"
    restrict: "E"
    template: """
    <div class="gb-file-diff">

      <div class="diff-content">
        <div ng-show="data" class="chunk" ng-repeat="chunk in data">

          <div class="col">
            <div ng-repeat="line in chunk">
              <span class="lineno">{{line.minus}}</span>
              <span class="lineno">{{line.plus}}</span>
            </div>
          </div>

          <div class="code">
            <pre ng-repeat="line in chunk" class="line {{line.type}}">{{line.content}}</pre>
          </div> <!-- .line -->

        </div> <!-- .chunk -->
        <div class="loading" ng-hide="data">Loading...</div>
      </div>

      <div ng-show="stageMode" class="sk-center sk-button-group">
        <button ng-click="stage()">Stage file</button>
      </div>

      <div ng-hide="stageMode" class="sk-center sk-button-group">
        <button ng-click="unstage()">Unstage file</button>
      </div>

    </div> <!-- .gb-file-diff -->
    """
    link: (scope, el, attrs, overlay) ->
      git.on("diff", (file, data, stageMode) ->
        scope.file = file
        scope.data = data
        scope.stageMode = stageMode
      )
      scope.stage = ->
        git.ctx.exec("stage", scope.file)
        overlay.scope.hide()
      scope.unstage = ->
        git.ctx.exec("unstage", scope.file)
        overlay.scope.hide()

]
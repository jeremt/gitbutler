
module.exports = [

  "GitService"

  (git) ->
    restrict: "E"
    template: """
    <div class="gb-file-diff">
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
      <div ng-hide="data">Loading...</div>
    </div> <!-- .gb-file-diff -->
    """
    link: (scope) ->
      git.on("diff", (data) ->
        scope.data = data
      )

]
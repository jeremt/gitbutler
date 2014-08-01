
module.exports = ->
  restrict: "E"
  replace: true
  template: """
  <div ng-click="select()" class="gb-commit sk-box {{type}}">
    <div class="message">{{message}}</div>
    <footer class="sk-small">
      <span class="author">{{author}}</span>
      <span class="date">{{date}}</span>
    </footer>
  </div>
  """
  scope:
    message: "@"
    date: "@"
    author: "@"
    type: "@"
    hash: "@"
  link: (scope) ->
    scope.select = ->
      window.alert("Checkout commit #{scope.hash}")
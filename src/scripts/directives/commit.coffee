
module.exports = ->
  restrict: "E"
  replace: true
  template: """
  <div class="gb-commit sk-box {{type}}">
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
  link: (scope) ->

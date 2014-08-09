
gitbutler = angular.module("gitbutler", [])

# Load appSkeleton's widgets
require("./scripts/sk")(gitbutler)

require("./scripts/filters")(gitbutler)
require("./scripts/directives")(gitbutler)
require("./scripts/controllers")(gitbutler)
require("./scripts/services")(gitbutler)

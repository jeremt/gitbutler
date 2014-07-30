
gitbutler = angular.module("gitbutler", [])

# Load appSkeleton's widgets
require("./scripts/sk")(gitbutler)

# Load directives
require("./scripts/directives")(gitbutler)
require("./scripts/controllers")(gitbutler)
require("./scripts/services")(gitbutler)

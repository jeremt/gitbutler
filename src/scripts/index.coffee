
gitbutler = angular.module("gitbutler", [])

# Load appSkeleton's widgets
require("./scripts/sk")(gitbutler)

# Load directives
require("./scripts/directives")(gitbutler)

# Load controllers
require("./scripts/controllers/app")(gitbutler)
require("./scripts/controllers/views")(gitbutler)

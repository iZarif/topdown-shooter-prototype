local fennel = require("lib.fennel")

table.insert(package.loaders, fennel.searcher)
fennel.dofile("game.fnl")

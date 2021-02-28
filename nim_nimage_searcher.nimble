# Package

version       = "0.1.0"
author        = "suihakei"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["nim_nimage_searcher"]
binDir        = "bin"



# Dependencies

requires "nim >= 1.2.6"
requires "https://github.com/nnahito/nim-image-similar"
requires "wnim"
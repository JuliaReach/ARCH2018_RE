#!/bin/bash

julia --color=yes -e 'Pkg.clone("https://github.com/JuliaReach/Reachability.git")'
julia --color=yes -e 'Pkg.clone("https://github.com/JuliaReach/ARCH2018_RE.git")'
julia --color=yes -e 'Pkg.test("Reachability")'

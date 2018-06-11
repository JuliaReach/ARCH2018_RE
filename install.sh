#!/bin/bash

julia --color=yes -e 'Pkg.clone("https://github.com/JuliaReach/Reachability.jl")'
julia --color=yes -e 'Pkg.clone("https://github.com/JuliaReach/ARCH2018_RE.jl")'
julia --color=yes -e 'Pkg.test("Reachability")'
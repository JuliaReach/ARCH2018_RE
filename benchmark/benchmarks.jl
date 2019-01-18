using BenchmarkTools, ARCH2018_RE

@static if VERSION >= v"0.7"
    using SparseArrays, LinearAlgebra
end

SUITE = BenchmarkGroup()

include("../src/SpaceStation/iss.jl")
include("../src/Building/build.jl")

#=
# From BenchmarkTools.jl
# ----------------------
paramspath = joinpath(dirname(@__FILE__), "params.json")

if isfile(paramspath)
    loadparams!(SUITE, BenchmarkTools.load(paramspath)[1], :evals);
else
    tune!(SUITE)
    BenchmarkTools.save(paramspath, params(SUITE));
end
=#

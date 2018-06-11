using BenchmarkTools, ARCH2018_RE
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

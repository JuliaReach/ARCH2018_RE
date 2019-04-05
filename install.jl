Pkg.add("MathematicalSystems");
repo = LibGit2.GitRepo(joinpath(Pkg.dir(), "MathematicalSystems"));
LibGit2.branch!(repo, "Pin_3451c", "3451ce51bfa15078279610d5d8c3eb62f23ca3ea");

Pkg.add("LazySets");
repo = LibGit2.GitRepo(joinpath(Pkg.dir(), "LazySets"));
LibGit2.branch!(repo, "Pin_08150", "08150a1307f9c25c5e02fe7fe9a74e102049bd6e");

Pkg.add("Reexport");

Pkg.clone("https://github.com/JuliaReach/SX.jl.git");
repo = LibGit2.GitRepo(joinpath(Pkg.dir(), "SX"));
LibGit2.branch!(repo, "Pin_0bee1", "0bee143c44c1e6d9210e6754910f03bca7ad1a11");

try
    Pkg.clone("https://github.com/JuliaReach/Reachability.jl.git");
catch
    repo = LibGit2.GitRepo(joinpath(Pkg.dir(), "Reachability"));
    LibGit2.branch!(repo, "Pin_73f9e", "73f9ee92342e4d46418589d34200c5682bcb8609");
end

Pkg.clone("https://github.com/JuliaReach/ARCH2018_RE.git")'

# ARCH2018_RE

This is the readme file of the ARCH2018 Repeatibility Evaluation (RE) package.
Instructions are provided for installing and running the benchmarks.

*Note.* `ARCH18_RE.jl` is just a "wrapper" module for running the benchmarks of this RE.
The actual algorithms belong to the package [Reachability.jl](https://github.com/JuliaReach/Reachability.jl).

## Introduction

This year we have considered purely continuous models only. These are:

- International Space Station (ISS) alias `SpaceStation`.
- Building model alias `Building`. 

**Overview.** To install and run the benchmarks, basically these three steps are needed:

1. Download and install Julia using the official download links.
2. Download `Reachability.jl` and its dependencies. For that purpose we provide the script `install.sh`.
3. Run the benchmarks and obtain results. For that purpose we provide the script `run.sh`. The results
   are saved in the file `results.md`.

Below we explain these steps in some detail. A section on known issues is given
in the end. If you still have problems or questions, do contact us in
our [gitter channel](https://gitter.im/JuliaReach/Lobby) or via email.

### About JuliaReach

*JuliaReach* is a software framework for reachability computations of dynamical systems, available at the [JuliaReach github project website](http://github.com/JuliaReach).
It is written in Julia, a modern high-level language for scientific computing.
Currently *JuliaReach* can handle continuous affine systems. The reachability algorithm uses a block decomposition technique presented in *DBLP:conf/hybrid/BogomolovFFVPS18*.
Here we partition the state space, project the initial states to subspaces, and propagate these low-dimensional sets in time. This allows us to perform otherwise expensive set operations in low dimensions. Furthermore, if the output does not depend on all dimensions, we can effectively skip the reach set computation for the respective dimensions. In the evaluation we used two-dimensional blocks, for which our implementation supports epsilon-close approximation; for box approximation we can handle arbitrary partitions.
For the set computations we use the *LazySets* library, which is also part of the *JuliaReach* framework.
*LazySets* exploits the principle of lazy (on-demand) evaluation and uses support functions to represent lazy sets.
*JuliaReach* also comes with *SX*, a parser for SX (SpaceEx format) model files.
For next year we plan to add support for hybrid dynamics, which will require a careful balance between low- and high-dimensional computations and adaptive choice of the partition.

## Installation

This package requires Julia v0.6.x. Refer to the [official documentation](https://julialang.org/downloads)
on how to install and run Julia in your system. 

Once you have installed Julia, you should be able to open it in a terminal (shell)
with the command `julia`, and see the welcome message similar to


```
$ julia
               _
   _       _ _(_)_     |  A fresh approach to technical computing
  (_)     | (_) (_)    |  Documentation: https://docs.julialang.org

   _ _   _| |_  __ _   |  Type "?help" for help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 0.6.1 (2017-10-24 22:15 UTC)
 _/ |\__'_|_|_|\__'_|  |  Official http://julialang.org/ release
|__/                   |  x86_64-apple-darwin14.5.0

julia>
```

To install the reachability API we provide the shell script `install.sh` contained
in this folder. Execute the script `install.sh` with the command:

```
$ ./install.sh
```

*Note.* The script `install.sh` evaluates the following commands in your Julia installation:

```julia
julia> Pkg.clone("https://github.com/JuliaReach/Reachability.jl")
julia> Pkg.clone("https://github.com/JuliaReach/ARCH2018_RE.jl")
julia> Pkg.add("BenchmarkTools")
julia> Pkg.add("PkgBenchmark")
```
Since `Reachability.jl` has several dependencies and the other packages also
have their dependencies, this whole process will take between 5-20 minutes in a fresh
Julia installation.

## Running the benchmarks

To run and get the benchmark results in the file `results.md`, execute the
bash script `run.sh` with the command:

```
$ ./run.sh
```

The `results.md` file is saved in your current working directory.

*Note.* This script automatically executes the commands needed to launch the reachability computations,

```julia
julia> using PkgBenchmark, Reachability
julia> results = benchmarkpkg("ARCH2018_RE")
julia> export_markdown("results.md", results)
```
Each computation is performed several times, to reduce noise and obtain
statistically meaningful timings. In the results tables, the reported time is the minimum time.
Other statistics such as mean and max values can be found by looking at the entries
of the `results` structure. For more advanced settings we refer to the official
[BenchmarkTools](https://github.com/JuliaCI/BenchmarkTools.jl/blob/master/doc/manual.md) documentation.

## Known issues

1. To be able to run the shell script, you may have to give the appropriate permissions.
   In Linux and MacOS systems this is done with the command:

   ```
   $ chmod 744 run.sh
   ```

2. If running one of the shell scripts give failures, try running it a second time.
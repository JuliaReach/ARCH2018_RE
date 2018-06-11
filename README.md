# ARCH2018_RE

This is the readme file of the ARCH2018 Repeatibility Evaluation (RE) package.
Instructions are provided for installing and running the benchmarks.

*Note.* `ARCH18_RE.jl` is just a "wrapper" module for running the benchmarks of this RE.
The actual algorithms belong to the package [Reachability.j](https://github.com/JuliaReach/Reachability.jl).

## Introduction

This year we have considered purely continuous models only. These are:

- International Space Station (ISS) alias `SpaceStation`.
- Building model alias `Building`. 

*Overview.* To install and run the benchmarks, basically these three steps are needed:

1. Download and install Julia using the official download links.
2. Download `Reachability.jl` and its dependencies using the script `install.sh`.
3. Run the benchmarks and obtain results using the script `run.sh`.

Below we explain these steps in some detail. A section on known issues is given
in the end. If you still have problems or questions, do contact us in
our [gitter channel](https://gitter.im/JuliaReach/Lobby) or via email.

## Installation

This package requires Julia v0.6. Refer to the [official documentation](https://julialang.org/downloads)
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
have their dependencies, this whole process will take several minutes in a fresh
Julia installation.

## Running the benchmarks

To run and get the benchmark results in the file `results.md`, execute the
bash script `run.sh` with the command:

```
$ ./run.sh
```

The `results.md` file is saved in your current working directory.

*Note.* This script just executes the commands needed to execute the reachability computations
in the `/src` folder. These computations are done several times, to obtain statistically
meaningful timings.

## Known issues

1. To be able to run the shell script, you may have to give the appropriate permissions.
   In Linux and MacOS systems this is done with the command:

   ```
   $ chmod 744 run.sh
   ```

2. If running a script gave failures, try running it a second time.
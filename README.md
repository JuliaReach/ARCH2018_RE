# ARCH2018_RE

:trophy: :nerd_face: The *Most Promising Research Award* of the ARCH 2018 Friendly Competition was given to [JuliaReach](juliareach.org) for the results obtained in the `ARCH2018_RE`, see the [announcement here](https://cps-vo.org/node/55228).

---

:newspaper: :checkered_flag: The paper with the results of the RE is now available online, [ARCH-COMP18 Category Report: Continuous and Hybrid Systems with Linear Continuous Dynamics](https://easychair.org/publications/paper/4cGr). Matthias Althoff, Stanley Bak, Xin Chen, Chuchu Fan, Marcelo Forets, Goran Frehse, Niklas Kochdumper, Yangge Li, Sayan Mitra, Rajarshi Ray, Christian Schilling and Stefan Schupp (2018) ARCH18. 5th International Workshop on Applied Verification of Continuous and Hybrid Systems, 54: 23–52. doi: 10.29007/73mb. Packages: [Reachability.jl.](https://github.com/JuliaReach/Reachability.jl)

---

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
2. Clone this repository and run the `install.sh` script to install the required
   Julia packages and dependencies.
3. Run the benchmarks to obtain results using the script `run.sh` and see `results.md`.

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

**Important note.** The `master` branch in this repository and the installation
script `insta..sh` are meant to be a "screenshot" of the packages ecosystem for
this RE. If you intend to use JuliaReach for other purposes, we highly recommend
that you use the currently long-term support Julia version and follow the installation
instructions in [Reachability.jl](https://github.com/JuliaReach/Reachability.jl).
See also the [ReachabilityBenchmarks](https://github.com/JuliaReach/ReachabilityBenchmarks.jl)
project, which contains updated model files for the latest packages versions.

This RE requires Julia v0.6.4. Refer to the [official documentation](https://julialang.org/downloads)
on how to install and run Julia in your system. Notice that v0.6.4 is currently
found under the *older releases* page.

Once you have installed Julia, you should be able to change directory where the
command `julia` is available to run the program, and once you do `$ julia`,
the welcome message similar to:

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

*Note.* The installation and compilation time depends with an average internet
connection can take around 10-20 minutes.

## Running the benchmarks

To run the benchmarks execute:

```
$ julia --color=yes run.jl
```

A `results.md` file containing the results for each benchmark in table format is
saved in your current working directory.

*Note.*  To obtain statistically meaningful performance measures, each reachability
computation is performed several times. The script can take several minutes. The
time displayed in the tables is the minimum time for the given trials. If you are
interested in other statistics, such as mean or median, these can be found by
looking at the entries of the `results` object.

For more advanced testing settings we refer to the official
[BenchmarkTools](https://github.com/JuliaCI/BenchmarkTools.jl/blob/master/doc/manual.md)
documentation.

## Troubleshooting

1. To be able to run the shell script, you may have to give the appropriate permissions.
   In Linux and MacOS systems this is done with the command:

   ```
   $ chmod 744 install.sh
   ```

2. If running one scripts give failures, try running it a second time.

3. See also the installation instructions of the [LazySets.jl](https://juliareach.github.io/LazySets.jl/latest/man/getting_started.html) library.

4. If you still have trouble, don't hesitate to contact us in our
[gitter channel](https://gitter.im/JuliaReach/Lobby).

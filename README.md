# ARCH2018 AFF

This is the JuliaReach repeatability evaluation (RE) package for the ARCH-COMP
2018 category report: Continuous and Hybrid Systems with Linear Continuous
Dynamics of the 2nd International Competition on Verifying Continuous and Hybrid
Systems (ARCH-COMP '18).

:trophy: :nerd_face: The *Best Result Award* of the ARCH 2018 Friendly Competition
was given to [JuliaReach](juliareach.org). See the
[announcement here](https://cps-vo.org/node/55228).

To cite the work, you can use:

```
@inproceedings{AlthoffB0FFFKLM18,
  author    = {Matthias Althoff and
               Stanley Bak and
               Xin Chen and
               Chuchu Fan and
               Marcelo Forets and
               Goran Frehse and
               Niklas Kochdumper and
               Yangge Li and
               Sayan Mitra and
               Rajarshi Ray and
               Christian Schilling and
               Stefan Schupp},
  editor    = {Goran Frehse and
               Matthias Althoff and
               Sergiy Bogomolov and
               Taylor T. Johnson},
  title     = {{ARCH-COMP18} Category Report: Continuous and Hybrid Systems with
               Linear Continuous Dynamics},
  booktitle = {{ARCH}},
  series    = {EPiC Series in Computing},
  volume    = {54},
  pages     = {23--52},
  publisher = {EasyChair},
  year      = {2018},
  url       = {https://doi.org/10.29007/73mb},
  doi       = {10.29007/73mb}
}
```

## Introduction

Instructions are provided for installing and running the benchmarks.

*Note.* `ARCH18_RE.jl` is just a "wrapper" module for running the benchmarks of this RE.
The actual algorithms belong to the package [Reachability.jl](https://github.com/JuliaReach/Reachability.jl).

This year we have considered purely continuous models only. These are:

- International Space Station (ISS) alias `SpaceStation`.
- Building model alias `Building`.

**Overview.** To install and run the benchmarks, basically these three steps are needed:

1. Download and install Julia v0.6.4 using the official download links.
2. Clone this repository and run the script `install.jl` to install the required
   Julia packages and dependencies.
3. Run the benchmarks to obtain results using the script `run.jl`; the reuslts
   are stored in `results.md`.

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

**IMPORTANT NOTE.** The `master` branch in this repository and the installation
script `install.jl` are meant to be a "screenshot" of the packages ecosystem for
this RE. If you intend to use JuliaReach for other purposes than RE, we strongly recommend
that you use instead the currently long-term support Julia version, and follow the installation
instructions in [Reachability.jl](https://github.com/JuliaReach/Reachability.jl).
Moreover, the [ReachabilityBenchmarks](https://github.com/JuliaReach/ReachabilityBenchmarks.jl)
project contains updated model files for the latest package versions.

This RE requires Julia `v0.6.4`. Refer to the [official documentation](https://julialang.org/downloads)
on how to install and run Julia in your system. As of 05/04/2019, Julia version
`v0.6.4` is found under the [older releases](https://julialang.org/downloads/oldreleases.html) page.
This RE does not work with Julia v1.0 or higher (see note above).

After installing Julia, the REPL (read-evaluate-print-loop) welcome message
should look like:

```
$ julia
               _
   _       _ _(_)_     |  A fresh approach to technical computing
  (_)     | (_) (_)    |  Documentation: https://docs.julialang.org
   _ _   _| |_  __ _   |  Type "?help" for help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 0.6.4 (2018-07-09 19:09 UTC)
 _/ |\__'_|_|_|\__'_|  |  Official http://julialang.org/ release
|__/                   |  x86_64-apple-darwin14.5.0

julia>
```

Clone this repository and then install this RE and dependencies with the
self-contained script `install.jl`.

```
$ git clone https://github.com/JuliaReach/ARCH2018_RE.git
$ cd ARCH2018_RE/
$ julia --color=yes install.jl
```

*Note.* The installation and compilation of dependencies, with an average internet
connection and machine, may take around 15-30 minutes.

## Running the benchmarks

To run the benchmarks, execute the `run.jl` script provided in this package:

```
$ julia --color=yes run.jl
```

A `results.md` file containing the results for each benchmark in tabular format is
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

1. If running one of the scripts fails, try running it a second time.

2. See also the installation instructions of the [LazySets.jl](https://juliareach.github.io/LazySets.jl/latest/man/getting_started.html) library.

3. If you still have trouble, don't hesitate to contact us in our
[gitter channel](https://gitter.im/JuliaReach/Lobby).

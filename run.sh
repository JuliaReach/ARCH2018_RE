#!/bin/bash

julia --color=yes -e 'using PkgBenchmark, Reachability; results = benchmarkpkg("ARCH2018_RE"); export_markdown("results.md", results)'
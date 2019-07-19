# ModularIndicies

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ericphanson.github.io/ModularIndicies.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://ericphanson.github.io/ModularIndicies.jl/dev)
[![Build Status](https://travis-ci.com/ericphanson/ModularIndicies.jl.svg?branch=master)](https://travis-ci.com/ericphanson/ModularIndicies.jl)
[![Codecov](https://codecov.io/gh/ericphanson/ModularIndicies.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/ericphanson/ModularIndicies.jl)
[![Coveralls](https://coveralls.io/repos/github/ericphanson/ModularIndicies.jl/badge.svg?branch=master)](https://coveralls.io/github/ericphanson/ModularIndicies.jl?branch=master)

A simple package with one export: `Mod`. This is an object using for indexing, like `Colon` from Base, and `Not` from [InvertedIndices.jl](https://github.com/mbauman/InvertedIndices.jl).

Usage:
```julia
julia> A = rand(5)
5-element Array{Float64,1}:
 0.42359227989772474
 0.5413728926587569
 0.45985418309577053
 0.7069364422785294
 0.3925745981095885

julia> A[Mod(6)]
0.42359227989772474

julia> A[6]
ERROR: BoundsError: attempt to access 5-element Array{Float64,1} at index [6]
Stacktrace:
 [1] getindex(::Array{Float64,1}, ::Int64) at ./array.jl:729
 [2] top-level scope at none:0
```

This package should possibly be called `PeriodicIndicies` and `Mod` renamed to `Periodic` or similar.

This is similar to [FFTViews.jl](https://github.com/JuliaArrays/FFTViews.jl), but instead of constructing a periodic view type into an array,
it provides an indexing object.

The code is heavily inspired by InvertedIndices.jl (but it's actually much simpler to do modular indexing than inverted indexing), and the idea for `Mod` was discussed on <https://github.com/JuliaLang/julia/issues/32571>.


## Examples

```julia
julia> A = 1:3
1:3

julia> A[Mod(4)]
1

julia> A[Mod(2:4)]
3-element Array{Int64,1}:
 2
 3
 1

julia> A = reshape(1:8, 2, 4)
2×4 reshape(::UnitRange{Int64}, 2, 4) with eltype Int64:
 1  3  5  7
 2  4  6  8

julia> A[Mod(4),2]
 4
```

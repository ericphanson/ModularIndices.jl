module ModularIndicies

using Base: tail
import Base.getindex
export Mod

include("TupleVector.jl")

"""
    Mod(idx)

Construct a modular (periodic) index.

# Examples
```jldoctest
julia> A = 1:3
1:3

julia> A[Mod(4)]
1

julia> A[Mod(2:4)]
3-element Array{Int64,1}:
 2
 3
 1
 
```

"""
struct Mod{S}
    ind::S
end

Mod(i₁::Integer, i₂::Integer, iₓ::Integer...) = Mod(TupleVector((i₁, i₂, iₓ...)))


# The `mod_range` function is modified from https://github.com/JuliaLang/julia/pull/32628
# This does the actual modular arithmetic.
@inline mod_range(i::Integer, r::Base.OneTo) = mod1(i, last(r))
@inline mod_range(i::Integer, r::AbstractUnitRange) = mod(i-first(r), length(r)) + first(r)
@inline mod_range(i::Integer, r::StepRange) = abs(r.step)==1 ? mod(i-minimum(r), length(r)) + minimum(r) :
    throw(ArgumentError("step must be +1 or -1"))

@inline mod_range(i::AbstractUnitRange, r) = TupleVector(ntuple(j -> mod_range(i[j], r), length(i)))
@inline mod_range(i::TupleVector, r) = TupleVector(ntuple(j -> mod_range(i[j], r), length(i)))


# The key bit: peel off `Mod`'s and compute the mod given the axis information (in `inds`)
# For example, A[Mod(5)] == A[mod_range(5, axes(A, 1))]
@inline function Base.to_indices(A, inds, I::Tuple{Mod, Vararg{Any}})
    return to_indices(A, inds, (mod_range(I[1].ind, inds[1]), tail(I)...))

end

end # module

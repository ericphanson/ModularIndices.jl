using Documenter, ModularIndicies

makedocs(;
    modules=[ModularIndicies],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/ericphanson/ModularIndicies.jl/blob/{commit}{path}#L{line}",
    sitename="ModularIndicies.jl",
    authors="Eric P. Hanson",
    assets=String[],
)

deploydocs(;
    repo="github.com/ericphanson/ModularIndicies.jl",
)

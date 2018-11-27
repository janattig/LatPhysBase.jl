using LatPhysBase
using Test

@testset "LatPhysBase.jl" begin

    # include subfile for abstract type tests
    include("tests_abstract_types.jl")

    # include subfile for default labels
    include("tests_default_labels.jl")

    # include subfile for concrete type tests
    include("tests_concrete_types.jl")

    # include subfile for custom type printing tests
    include("tests_custom_printing.jl")

end

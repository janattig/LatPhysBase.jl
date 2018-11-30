# TESTSET FOR ALL ABSTRACT TYPES
# mainly test dependencies of abstract types and availability
@testset "Abstract Type Definitions" begin

    #-----------------
    #   SITES
    #-----------------
    @testset "AbstractSite" begin

        @test AbstractSite{String, 2} <: AbstractSite{L,D} where {L,D}
        @test AbstractSite{Int64, 3}  <: AbstractSite{L,D} where {L,D}

    end


    #-----------------
    #   BONDS
    #-----------------
    @testset "AbstractBond" begin

        @test AbstractBond{String, 2} <: AbstractBond{L,N} where {L,N}
        @test AbstractBond{Int64, 3}  <: AbstractBond{L,N} where {L,N}

    end


    #-----------------
    #   UNITCELLS
    #-----------------
    @testset "AbstractUnitcell" begin

        @test AbstractUnitcell{AbstractSite{String,3}, AbstractBond{Int64, 3}}  <: AbstractUnitcell{S, B} where {S,B}
        @test AbstractUnitcell{AbstractSite{Int64,2}, AbstractBond{Float64, 2}} <: AbstractUnitcell{S, B} where {S,B}

    end


    #-----------------
    #   LATTICES
    #-----------------
    @testset "AbstractLattice" begin

        @test AbstractLattice{AbstractSite{String,3}, AbstractBond{Int64, 3}, AbstractUnitcell{AbstractSite{String,3}, AbstractBond{Int64, 3}}}  <: AbstractLattice{S, B, U} where {S,B,U}
        @test AbstractLattice{AbstractSite{Int64,2}, AbstractBond{Float64, 2}, AbstractUnitcell{AbstractSite{String,3}, AbstractBond{Int64, 3}}} <: AbstractLattice{S, B, U} where {S,B,U}

    end

# end the testset
end

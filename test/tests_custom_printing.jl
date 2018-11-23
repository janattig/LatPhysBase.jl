# TESTSET FOR ALL CUSTOM PRINTING FUNCTIONS
@testset "Custom Pretty Printing of Types" begin

    #-----------------
    #   SITES
    #-----------------
    @testset "Sites" begin

        # single site
        println("---")
        @test_nowarn println(newSite(Site{String,2}, [0.0, 0.0], "site 1"))
        @test_nowarn println(newSite(Site{Int64,2}, [0.0, 0.0], 1))
        @test_nowarn println(newSite(Site{Float64,3}, [0.0, 0.0, 0.0], 1.0))

        # multiple sites (list of sites)
        println("---")
        @test_nowarn println([newSite(Site{Int64,2}, [0.0, 0.0], i) for i in 1:10])

    end


    #-----------------
    #   BONDS
    #-----------------
    @testset "Bonds" begin

        # single bond
        println("---")
        @test_nowarn println(newBond(Bond{String,2}, 1,1, "site 1", (0,0)))
        @test_nowarn println(newBond(Bond{Int64,3}, 1,1, 1, (0,0,1)))
        @test_nowarn println(newBond(Bond{Float64,2}, 1,1, 1.0, (0,0)))

        # multiple sites (list of bonds)
        println("---")
        @test_nowarn println([newBond(Bond{Int64,2}, 1,1, i, (0,0)) for i in 1:10])

    end

# end the testset
end

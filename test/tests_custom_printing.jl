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
        @test_nowarn println(newSite(Site{Float64,2}, [0.0, 0.0], 1.0))

        # multiple sites (list of sites)
        println("---")
        @test_nowarn println([newSite(Site{Int64,2}, [0.0, 0.0], i) for i in 1:10])
        println("---")


    end

# end the testset
end

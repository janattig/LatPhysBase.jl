# TESTSET FOR ALL CUSTOM PRINTING FUNCTIONS
@testset "Custom Pretty Printing of Types" begin

    #-----------------
    #   SITES
    #-----------------
    @testset "Sites" begin

        # single site
        @test_nowarn println(newSite(Site{String,2}, [0.0, 0.0], "site 1"))


    end

# end the testset
end

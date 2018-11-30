# TESTSET FOR ALL DEFAULT LABEL FUNCTIONS
@testset "Default labels" begin


    #-----------------
    #   ULTIMATE DEFAULT (no specification)
    #-----------------
    @testset "Ultimate Default" begin

        # only one function to test
        @test_nowarn getDefaultLabel(Int64)
        @test_nowarn getDefaultLabel(Float64)
        @test_nowarn getDefaultLabel(Complex)
        @test_nowarn getDefaultLabel(String)
        @test_nowarn getDefaultLabel(Symbol)

    end


    #-----------------
    #   AB DEFAULT (sublattice)
    #-----------------
    @testset "AB Default" begin

        # A part
        @test_nowarn getDefaultLabelA(Int64)
        @test_nowarn getDefaultLabelA(Float64)
        @test_nowarn getDefaultLabelA(Complex)
        @test_nowarn getDefaultLabelA(String)
        @test_nowarn getDefaultLabelA(Symbol)

        # B part
        @test_nowarn getDefaultLabelB(Int64)
        @test_nowarn getDefaultLabelB(Float64)
        @test_nowarn getDefaultLabelB(Complex)
        @test_nowarn getDefaultLabelB(String)
        @test_nowarn getDefaultLabelB(Symbol)

    end


    #-----------------
    #   XYZ DEFAULT (Kitaev)
    #-----------------
    @testset "XYZ Default" begin

        # X part
        @test_nowarn getDefaultLabelX(Int64)
        @test_nowarn getDefaultLabelX(Float64)
        @test_nowarn getDefaultLabelX(Complex)
        @test_nowarn getDefaultLabelX(String)
        @test_nowarn getDefaultLabelX(Symbol)

        # Y part
        @test_nowarn getDefaultLabelY(Int64)
        @test_nowarn getDefaultLabelY(Float64)
        @test_nowarn getDefaultLabelY(Complex)
        @test_nowarn getDefaultLabelY(String)
        @test_nowarn getDefaultLabelY(Symbol)

        # Z part
        @test_nowarn getDefaultLabelZ(Int64)
        @test_nowarn getDefaultLabelZ(Float64)
        @test_nowarn getDefaultLabelZ(Complex)
        @test_nowarn getDefaultLabelZ(String)
        @test_nowarn getDefaultLabelZ(Symbol)

        # Symbol part with extra prefix
        @test_nowarn getDefaultLabelX(Symbol, "J")
        @test_nowarn getDefaultLabelY(Symbol, "J")
        @test_nowarn getDefaultLabelZ(Symbol, "J")

        # String part with extra prefix
        @test_nowarn getDefaultLabelX(String, "t")
        @test_nowarn getDefaultLabelY(String, "t")
        @test_nowarn getDefaultLabelZ(String, "t")

    end


    #-----------------
    #   N DEFAULT (labels 1...N)
    #-----------------
    @testset "N Default" begin

        # iterate over certain range of numbers
        for n in Int64[1,2,3,4,5,10,20,50,100]
            # N part for this number
            @test_nowarn getDefaultLabelN(Int64,   n)
            @test_nowarn getDefaultLabelN(Float64, n)
            @test_nowarn getDefaultLabelN(Complex, n)
            @test_nowarn getDefaultLabelN(String,  n)
            @test_nowarn getDefaultLabelN(Symbol,  n)
        end

    end


# end the testset
end

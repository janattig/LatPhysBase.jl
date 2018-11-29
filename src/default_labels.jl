################################################################################
#
#	FILE TO IMPLEMENT DEFAULT LABELS
#   (labels of a specific type if needed)
#
#   FILE CONTAINS
#   - fallback default labels (1)
#   - A,B
#   - x,y,z
#   - 1,...,N
#
################################################################################



################################################################################
#
#	ULTIMATE DEFAULT LABELS
#   (labels of only a specific type if needed)
#
################################################################################

# Fallback / Interface
function getDefaultLabel(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabel(::Type{" * string(T) * "}, prefix::String=\"\")` to fix this")
end

# export
export getDefaultLabel


# Implementation for string
function getDefaultLabel(
            ::Type{T},
            prefix :: String = "1"
        ) :: T where {T <: AbstractString}

    # return "1" as a string of that type
    return T(prefix)
end
# Implementation for number
function getDefaultLabel(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: Number}

    # return "1" as a string of that type
    return T(1)
end
# Implementation for symbol
function getDefaultLabel(
            ::Type{T},
            prefix :: String = "l"
        ) :: T where {T <: Symbol}

    # return :l as a symbol of that type (short for label)
    return Symbol(prefix)
end




################################################################################
#
#	AB DEFAULT LABELS
#   (labels of only a specific type if needed that encode AB sublattices)
#
################################################################################

# Fallback / Interface
function getDefaultLabelA(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabelA(::Type{" * string(T) * "}, prefix::String=\"\")` to fix this")
end
function getDefaultLabelB(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabelB(::Type{" * string(T) * "}, prefix::String=\"\")` to fix this")
end

# export
export getDefaultLabelA, getDefaultLabelB


# Implementation for string
function getDefaultLabelA(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: AbstractString}

    # return "A" as a string of that type
    return T(prefix * "A")
end
function getDefaultLabelB(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: AbstractString}

    # return "B" as a string of that type
    return T(prefix * "B")
end

# Implementation for Numbers
function getDefaultLabelA(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: Number}

    # return 1 as a number of that type
    return T(1)
end
function getDefaultLabelB(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: Number}

    # return 2 as a number of that type
    return T(2)
end

# Implementation for Symbol
function getDefaultLabelA(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: Symbol}

    # return :A as symbol
    return Symbol(prefix, "A")
end
function getDefaultLabelB(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: Symbol}

    # return :B as symbol
    return Symbol(prefix, "B")
end



################################################################################
#
#	XYZ DEFAULT LABELS
#   (labels of only a specific type if needed that encode xyz like in Kitaev)
#
################################################################################

# Fallback / Interface
function getDefaultLabelX(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabelX(::Type{" * string(T) * "}, prefix::String=\"\")` to fix this")
end
function getDefaultLabelY(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabelY(::Type{" * string(T) * "}, prefix::String=\"\")` to fix this")
end
function getDefaultLabelZ(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabelZ(::Type{" * string(T) * "}, prefix::String=\"\")` to fix this")
end

# export
export getDefaultLabelX, getDefaultLabelY, getDefaultLabelZ


# Implementation for string
function getDefaultLabelX(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: AbstractString}

    # return "x" as a string of that type
    return T(prefix * "x")
end
function getDefaultLabelY(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: AbstractString}

    # return "y" as a string of that type
    return T(prefix * "y")
end
function getDefaultLabelZ(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: AbstractString}

    # return "z" as a string of that type
    return T(prefix * "z")
end

# Implementation for Numbers
function getDefaultLabelX(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: Number}

    # return 1 as a number of that type
    return T(1)
end
function getDefaultLabelY(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: Number}

    # return 2 as a number of that type
    return T(2)
end
function getDefaultLabelZ(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: Number}

    # return 3 as a number of that type
    return T(3)
end


# Implementation for Symbols
function getDefaultLabelX(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: Symbol}

    # return :x as a symbol
    return Symbol(prefix, "x")
end
function getDefaultLabelY(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: Symbol}

    # return :y as a symbol
    return Symbol(prefix, "y")
end
function getDefaultLabelZ(
            ::Type{T},
            prefix :: String = ""
        ) :: T where {T <: Symbol}

    # return :z as a symbol
    return Symbol(prefix, "z")
end



################################################################################
#
#	1...N DEFAULT LABELS
#   (labels of only a specific type if needed that encode integers)
#
################################################################################

# Fallback / Interface
function getDefaultLabelN(
            ::Type{T},
            n :: I,
            prefix :: String = ""
        ) :: T where {T, I<:Integer}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " and integer type " * string(I) * " \n" *
        "Please provide a function `getDefaultLabelN(::Type{" * string(T) * "}, n::" * string(I) * ",prefix::String=\"\")` to fix this")
end

# export
export getDefaultLabelN



# Implementation for string
function getDefaultLabelN(
            ::Type{T},
            n :: I,
            prefix :: String = ""
        ) :: T where {T<:String, I<:Integer}

    # return the string version of that integer
    return T(prefix * string(n))
end

# Implementation for Numbers
function getDefaultLabelN(
            ::Type{T},
            n :: I,
            prefix :: String = ""
        ) :: T where {T<:Number, I<:Integer}

    # return the number version of that integer
    return T(n)
end

# Implementation for Symbols
function getDefaultLabelN(
            ::Type{T},
            n :: I,
            prefix :: String = "l"
        ) :: T where {T<:Symbol, I<:Integer}

    # return :ln as the symbol (l as short for label)
    return Symbol(prefix, n)
end

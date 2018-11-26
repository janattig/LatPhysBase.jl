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
            ::Type{T}
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabel(::Type{" * string(T) * "})` to fix this")
end

# export
export getDefaultLabel


# Implementation for string
function getDefaultLabel(
            ::Type{T}
        ) :: T where {T <: AbstractString}

    # return "1" as a string of that type
    return T("1")
end
# Implementation for number
function getDefaultLabel(
            ::Type{T}
        ) :: T where {T <: Number}

    # return "1" as a string of that type
    return T(1)
end




################################################################################
#
#	AB DEFAULT LABELS
#   (labels of only a specific type if needed that encode AB sublattices)
#
################################################################################

# Fallback / Interface
function getDefaultLabelA(
            ::Type{T}
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabelA(::Type{" * string(T) * "})` to fix this")
end
function getDefaultLabelB(
            ::Type{T}
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabelB(::Type{" * string(T) * "})` to fix this")
end

# export
export getDefaultLabelA, getDefaultLabelB


# Implementation for string
function getDefaultLabelA(
            ::Type{T}
        ) :: T where {T <: AbstractString}

    # return "A" as a string of that type
    return T("A")
end
function getDefaultLabelB(
            ::Type{T}
        ) :: T where {T <: AbstractString}

    # return "B" as a string of that type
    return T("B")
end

# Implementation for Numbers
function getDefaultLabelA(
            ::Type{T}
        ) :: T where {T <: Number}

    # return 1 as a number of that type
    return T(1)
end
function getDefaultLabelB(
            ::Type{T}
        ) :: T where {T <: Number}

    # return 2 as a number of that type
    return T(2)
end




################################################################################
#
#	XYZ DEFAULT LABELS
#   (labels of only a specific type if needed that encode xyz like in Kitaev)
#
################################################################################

# Fallback / Interface
function getDefaultLabelX(
            ::Type{T}
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabelX(::Type{" * string(T) * "})` to fix this")
end
function getDefaultLabelY(
            ::Type{T}
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabelY(::Type{" * string(T) * "})` to fix this")
end
function getDefaultLabelZ(
            ::Type{T}
        ) :: T where {T}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " \n" *
        "Please provide a function `getDefaultLabelZ(::Type{" * string(T) * "})` to fix this")
end

# export
export getDefaultLabelX, getDefaultLabelY, getDefaultLabelZ


# Implementation for string
function getDefaultLabelX(
            ::Type{T}
        ) :: T where {T <: AbstractString}

    # return "x" as a string of that type
    return T("x")
end
function getDefaultLabelY(
            ::Type{T}
        ) :: T where {T <: AbstractString}

    # return "y" as a string of that type
    return T("y")
end
function getDefaultLabelZ(
            ::Type{T}
        ) :: T where {T <: AbstractString}

    # return "z" as a string of that type
    return T("z")
end

# Implementation for Numbers
function getDefaultLabelX(
            ::Type{T}
        ) :: T where {T <: Number}

    # return 1 as a number of that type
    return T(1)
end
function getDefaultLabelY(
            ::Type{T}
        ) :: T where {T <: Number}

    # return 2 as a number of that type
    return T(2)
end
function getDefaultLabelZ(
            ::Type{T}
        ) :: T where {T <: Number}

    # return 3 as a number of that type
    return T(3)
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
            n :: I
        ) :: T where {T, I<:Integer}

    # throw error as this is not implemented yet
    error("Not implemented default label for type " * string(T) * " and integer type " * string(I) * " \n" *
        "Please provide a function `getDefaultLabelN(::Type{" * string(T) * "}, n::" * string(I) * ")` to fix this")
end

# export
export getDefaultLabelN



# Implementation for string
function getDefaultLabelN(
            ::Type{T},
            n :: I
        ) :: T where {T<:String, I<:Integer}

    # return the string version of that integer
    return T(string(n))
end

# Implementation for Numbers
function getDefaultLabelN(
            ::Type{T},
            n :: I
        ) :: T where {T<:Number, I<:Integer}

    # return the number version of that integer
    return T(n)
end

################################################################################
#
#	FILE TO IMPLEMENT DEFAULT LABELS
#   (labels of a specific type if needed)
#
#   FILE CONTAINS
#   - fallback default labels (1)
#   - x,y,z
#   - 1,...,tN
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
    error("not implemented default label for type " * string(T))
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

################################################################################
#
#	ABSTRACT TYPE
#
#   BondHamiltonian{L,N}
#   --> L is the label type of bonds
#   --> N is the dimension the bond term matrix (NxN matrix)
#
#   FILE CONTAINS
#       - abstract type definition
#       - interface definition
#
################################################################################






################################################################################
#
#   ABSTRACT TYPE DEFINITION
#
################################################################################
abstract type AbstractBondHamiltonian{L,N} end

# export the type
export AbstractBondHamiltonian



################################################################################
#
#	INTERFACING / ACCESSING BOND HAMILTONIANS
#	(functions have to be overwritten by concrete types)
#
################################################################################




# Fallback if wrong label type is passed (DOES NOT HAVE TO BE OVERWRITTEN)
function bondterm(
            h :: AbstractBondHamiltonian{LH,NH},
            b :: AbstractBond{LB,NB}
        ) :: Matrix{Complex} where {LB,NB,LH,NH}

    # print an error because implementation for concrete type is missing
    error("Passed a bond with different label type to a bond Hamiltonian\nLabel type of bond: "*string(LB)*", label type of bond Hamiltonian: "*string(LH))
end

# get bond term of Hamiltonian
function bondterm(
            h :: AbstractBondHamiltonian{L,NH},
            b :: AbstractBond{L,NB}
        ) :: Matrix{Complex} where {L,NB,NH}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'bondterm' for bond Hamiltonian type " * string(typeof(h)))
end





# fancy syntax of passing the bond to the object directly
function (hb :: Type{H})(b :: AbstractBond{LB,NB}) :: Matrix{Complex} where {LB,NB,LH,NH,H<:AbstractBondHamiltonian{LH,NH}}

    # return the bond term function
    return bondterm(hb, b)
end

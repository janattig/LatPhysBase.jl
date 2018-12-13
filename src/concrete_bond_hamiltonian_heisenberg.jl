################################################################################
#
#	ABSTRACT TYPE
#
#   BondSpinHamiltonianHeisenberg <: AbstractBondHamiltonian{L,N}
#   --> L is the label type of bonds
#   --> N is the dimension the bond term matrix (NxN matrix)
#
#   FILE CONTAINS
#       - abstract type definition
#       - interface definition
#       - generator function
#
################################################################################






################################################################################
#
#   ABSTRACT TYPE DEFINITION
#
################################################################################
mutable struct BondSpinHamiltonianHeisenberg{N,L,NS} <: AbstractBondHamiltonian{L,NS}

    # couplings
    J :: Vector{Float64}

    # bond labels of these couplings
    J_bonds :: Vector{Vector{L}}

end

# export the type
export BondSpinHamiltonianHeisenberg



################################################################################
#
#	INTERFACING / ACCESSING BOND HAMILTONIANS
#	(functions have to be overwritten by concrete types)
#
################################################################################



# get bond term of Hamiltonian
function bondterm(
            h :: BondSpinHamiltonianHeisenberg{N,L,NS},
            b :: AbstractBond{L,NB}
        ) :: Matrix{Complex} where {N,L,NB,NS}

    # get the bond label
    l = label(b)

    # check for all neighbors if the label is in one of the lists
    for i in 1:N
        if l in h.J_bonds[i]
            return zeros(NS,NS) + (h.J[i] * I)
        end
    end

    # if no bond found, return 0
    return zeros(NS,NS)
end

# export the function
export bondterm





# FUNCTIONS TO FIND BOND LABELS

# FALLBACK ANY LABEL TYPE
# if specific function for label type L not found, denote all bonds as nearest neighbors
function getBondLabelsHeisenberg(
        N :: Val{1},
        all_couplings :: Vector{L}
    ) :: Vector{L} where {L}

    # all couplings are nearest neighbors
    return all_couplings
end
function getBondLabelsHeisenberg(
        N :: Val{NB},
        all_couplings :: Vector{L}
    ) :: Vector{L} where {NB,L}

    # no couplings are further neighbors
    return L[]
end


# CONSTRUCTION FUNCTION
function getSpinHamiltonianHeisenberg(
            unitcell :: U,
            N :: Int64 = 1,
            NS :: Int64 = 3
        ) :: BondSpinHamiltonianHeisenberg{N,L,NS} where {L,NB,S,B<:AbstractBond{L,NB},U<:AbstractUnitcell{S,B}}

    # obtain all couplings
    couplings = unique!(label.(bonds(unitcell)))

    # create lists and initialize default couplings
    J = [1 for i in 1:N]
    J_bonds = [getBondLabelsHeisenberg(Val(i),couplings) for i in 1:N]

    # create and return a new object
    return BondSpinHamiltonianHeisenberg{N,L,NS}(J,J_bonds)
end

# export the construction function
export getSpinHamiltonianHeisenberg

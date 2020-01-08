################################################################################
#
#	CONCRETE TYPE
#
#   Unitcell{D,N,L,S,B} <: AbstractUnitcell{S,B}
#   --> S is the site type (<: AbstractSite{LS,D})
#       --> D is the dimension of embedding space
#       --> LS is the label type of sites
#   --> B is the bond type (<: AbstractBond{LB,N})
#       --> N is the dimension of the Bravais lattice that the bond is located in
#       --> LB is the label type of bonds
#
#   FILE CONTAINS
#       - concrete struct definition
#       - interface implementation
#
################################################################################


################################################################################
#
#   CONCRETE STRUCT DEFINITION
#
################################################################################
mutable struct Unitcell{S,B} <: AbstractUnitcell{S,B}

    # basis vectors of the Bravais lattice
    lattice_vectors	:: Vector{Vector{Float64}}

    # basis sites within the unitcell
    sites			:: Vector{S}

    # list of bonds
    bonds			:: Vector{B}

end

# export the concrete type
export Unitcell






################################################################################
#
#	INTERFACING / ACCESSING UNITCELLS
#	(functions have to be overwritten by concrete types)
#
################################################################################


# default constructor interface
# used for creation of new unitcells
function newUnitcell(
            :: Type{Unitcell{S,B}},
            lattice_vectors :: Vector{<:Vector{<:Real}},
            sites           :: Vector{S},
            bonds           :: Vector{B}
        ) :: Unitcell{S,B} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # return a newly created object
    Unitcell{S,B}(lattice_vectors, sites, bonds)
end





# accessing a list of lattice vectors
function latticeVectors(
            unitcell :: Unitcell{S,B}
        ) :: Vector{Vector{Float64}} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # return the list of lattice vectors
    return unitcell.lattice_vectors
end
# setting a list of lattice vectors
function latticeVectors!(
            unitcell        :: Unitcell{S,B},
            lattice_vectors :: Vector{<:Vector{<:Real}}
        ) where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # set the list of lattice vectors
    unitcell.lattice_vectors = lattice_vectors
end


# accessing a list of sites
function sites(
            unitcell :: Unitcell{S,B}
        ) :: Vector{S} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # return the list of sites
    return unitcell.sites
end
# setting a list of sites
function sites!(
            unitcell :: Unitcell{S,B},
            sites    :: Vector{S}
        ) where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # set the list of sites
    unitcell.sites = sites
end


# accessing a list of bonds
function bonds(
            unitcell :: Unitcell{S,B}
        ) :: Vector{B} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # return the list of bonds
    return unitcell.bonds
end
# setting a list of bonds
function bonds!(
            unitcell :: Unitcell{S,B},
            bonds    :: Vector{B}
        ) where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # set the list of bonds
    unitcell.bonds = bonds
end



function saveUnitcell(
        uc :: U,
        fn :: AbstractString,
        group :: AbstractString = "unitcell"
        ;
        append :: Bool = false
    ) where {LS,LB,D,N,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:Unitcell{S,B}}

    # determine the mode based on if one wants to append stuff
    if append
        mode = "r+"
    else
        mode = "w"
    end

    # determine the site and bond group names
    group_sites = group*"/sites"
    group_bonds = group*"/bonds"

    # open the file in mode
    h5open(fn, mode) do ucfile
        # create the top level group
        group_uc = g_create(ucfile, group)
        # save into the attributes in which groups the sites and bonds are stored
        attrs(group_uc)["sites"] = group_sites
        attrs(group_uc)["bonds"] = group_bonds
        # save types into the attributes
        attrs(group_uc)["site_type"] = string(S)
        attrs(group_uc)["bond_type"] = string(B)
        # number of bravais lattice dimensions
        attrs(group_uc)["N"] = Int64(N)
        # save further attributes

        # write bravais lattice vectors
        for i in 1:N
            group_uc["a"*string(i)] = latticeVectors(uc)[i]
        end
    end

    # save sites and bonds into the file
    saveSites(sites(uc), fn, group_sites, append=true)
    saveBonds(bonds(uc), fn, group_bonds, append=true)

    # return nothing
    return nothing
end

function loadUnitcell(
        ::Type{UC},
        fn :: AbstractString,
        group :: AbstractString = "unitcell"
    ) where {SUC<:AbstractSite,BUC<:AbstractBond,UC<:Union{Unitcell{SUC,BUC}, Unitcell}}

    # read the attribute data
    attr_data = h5readattr(fn, group)

    # determine the bravais lattice dimension
    N = attr_data["N"]

    # determine the site and bond group names
    group_sites = attr_data["sites"]
    group_bonds = attr_data["bonds"]

    # load bravais lattice vectors
    lattice_vectors = Vector{Float64}[]
    for i in 1:N
        push!(lattice_vectors, h5read(fn, group*"/a"*string(i)))
    end

    # load the sites
    site_list = loadSites(fn, group_sites)
    # load the bonds
    bond_list = loadBonds(fn, group_bonds)

    # determine site and bond type
    S = typeof(site_list[1])
    B = typeof(bond_list[1])

    # return new unitcell
    return newUnitcell(
        Unitcell{S,B},
        lattice_vectors,
        site_list,
        bond_list
    )
end


# convinience function for standard type
function loadUnitcell(
        fn :: AbstractString,
        group :: AbstractString = "unitcell"
    )

    return loadUnitcell(Unitcell, fn, group)
end

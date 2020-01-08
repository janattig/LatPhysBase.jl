################################################################################
#
#	CONCRETE TYPE
#
#   Lattice{S,B,U} <: AbstractLattice{S,B,U}
#   --> S is the site type (<: AbstractSite{LS,D})
#       --> D is the dimension of embedding space
#       --> LS is the label type of sites
#   --> B is the bond type (<: AbstractBond{LB,N})
#       --> N is the dimension of the Bravais lattice that the bond is located in
#       --> LB is the label type of bonds
#   --> U is the unitcell type (<: AbstractUnitcell{SU,BU})
#       --> SU is the site type of the unitcell (<: AbstractSite{LUS,DU})
#           --> DU is the dimension of embedding space (of the UC)
#           --> LUS is the label type of sites (of the UC)
#       --> BU is the bond type of the unitcell (<: AbstractBond{LUB,NU})
#           --> NU is the dimension of the Bravais lattice that the bond is located in (of the UC)
#           --> LUB is the label type of bonds (of the UC)
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
mutable struct Lattice{S,B,U} <: AbstractLattice{S,B,U}

    # basis vectors of the Bravais lattice
    lattice_vectors	:: Vector{Vector{Float64}}

    # all sites within the lattice
    sites			:: Vector{S}

    # list of bonds
    bonds			:: Vector{B}

    # unitcell
    unitcell        :: U

end

# export the concrete type
export Lattice






################################################################################
#
#	INTERFACING / ACCESSING LATTICES
#	(functions have to be overwritten by concrete types)
#
################################################################################


# default constructor interface
# used for creation of new lattices
function newLattice(
            ::Type{Lattice{S,B,U}},
            lattice_vectors :: Vector{<:Vector{<:Real}},
            sites           :: Vector{S},
            bonds           :: Vector{B},
            unitcell        :: U
        ) :: Lattice{S,B,U} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # return a newly created object
    Lattice{S,B,U}(lattice_vectors, sites, bonds, unitcell)
end





# accessing a list of lattice vectors
function latticeVectors(
            lattice :: Lattice{S,B,U}
        ) :: Vector{Vector{Float64}} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # return the list of lattice vectors
    return lattice.lattice_vectors
end
# setting a list of lattice vectors
function latticeVectors!(
            lattice         :: Lattice{S,B,U},
            lattice_vectors :: Vector{<:Vector{<:Real}}
        ) where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # set the list of lattice vectors
    lattice.lattice_vectors = lattice_vectors
end


# accessing a list of sites
function sites(
            lattice :: Lattice{S,B,U}
        ) :: Vector{S} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # return the list of sites
    return lattice.sites
end
# setting a list of sites
function sites!(
            lattice :: Lattice{S,B,U},
            sites   :: Vector{S}
        ) where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # set the list of sites
    lattice.sites = sites
end

# accessing a list of bonds
function bonds(
            lattice :: Lattice{S,B,U}
        ) :: Vector{B} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # return the list of bonds
    return lattice.bonds
end
# setting a list of bonds
function bonds!(
            lattice :: Lattice{S,B,U},
            bonds   :: Vector{B}
        ) where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # set the list of bonds
    lattice.bonds = bonds
end


# accessing the unitcell
function unitcell(
            lattice :: Lattice{S,B,U}
        ) :: U where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # return the unitcell
    return lattice.unitcell
end
# setting the unitcell
function unitcell!(
            lattice  :: Lattice{S,B,U},
            unitcell :: U
        ) :: U where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N}}

    # set the unitcell
    lattice.unitcell = unitcell
end




function saveLattice(
        lt :: L,
        fn :: AbstractString,
        group :: AbstractString = "lattice"
        ;
        append :: Bool = false
    ) where {LS,LB,D,N,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},SU,BU,U<:AbstractUnitcell{SU,BU},L<:Lattice{S,B,U}}

    # determine the mode based on if one wants to append stuff
    if append
        mode = "r+"
    else
        mode = "w"
    end

    # determine the site and bond group names
    group_sites    = group*"/sites"
    group_bonds    = group*"/bonds"
    group_unitcell = group*"/unitcell"

    # open the file in mode
    h5open(fn, mode) do ltfile
        # create the top level group
        group_lt = g_create(ltfile, group)
        # save into the attributes in which groups the sites and bonds are stored
        attrs(group_lt)["sites"]    = group_sites
        attrs(group_lt)["bonds"]    = group_bonds
        attrs(group_lt)["unitcell"] = group_unitcell
        # save types into the attributes
        attrs(group_lt)["site_type"]     = string(S)
        attrs(group_lt)["bond_type"]     = string(B)
        attrs(group_lt)["unitcell_type"] = string(U)
        # number of bravais lattice dimensions
        attrs(group_lt)["N"] = Int64(N)
        # save further attributes

        # write bravais lattice vectors
        for i in 1:N
            group_lt["a"*string(i)] = latticeVectors(lt)[i]
        end
    end

    # save sites, bonds and unitcell into the file
    saveSites(sites(lt), fn, group_sites, append=true)
    saveBonds(bonds(lt), fn, group_bonds, append=true)
    saveUnitcell(unitcell(lt), fn, group_unitcell, append=true)

    # return nothing
    return nothing
end

function loadLattice(
        ::Type{LT},
        fn :: AbstractString,
        group :: AbstractString = "lattice"
    ) where {SLT<:AbstractSite,BLT<:AbstractBond,ULT<:AbstractUnitcell,LT<:Union{Lattice{SLT,BLT,ULT},Lattice}}

    # read the attribute data
    attr_data = h5readattr(fn, group)

    # determine the bravais lattice dimension
    N = attr_data["N"]

    # determine the site and bond group names
    group_sites    = attr_data["sites"]
    group_bonds    = attr_data["bonds"]
    group_unitcell = attr_data["unitcell"]

    # load bravais lattice vectors
    lattice_vectors = Vector{Float64}[]
    for i in 1:N
        push!(lattice_vectors, h5read(fn, group*"/a"*string(i)))
    end

    # load the sites
    site_list = loadSites(fn, group_sites)
    # load the bonds
    bond_list = loadBonds(fn, group_bonds)
    # load the unitcell
    unitcell_loaded = loadUnitcell(fn, group_unitcell)

    # determine site and bond type
    S = typeof(site_list[1])
    B = typeof(bond_list[1])
    U = typeof(unitcell_loaded)

    # return new unitcell
    return newLattice(
        Lattice{S,B,U},
        lattice_vectors,
        site_list,
        bond_list,
        unitcell_loaded
    )
end


# convinience function for standard type
function loadLattice(
        fn :: AbstractString,
        group :: AbstractString = "lattice"
    )

    return loadLattice(Lattice, fn, group)
end

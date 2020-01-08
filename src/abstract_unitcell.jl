################################################################################
#
#	ABSTRACT TYPE
#
#   Unitcell{S,B}
#   --> S is the site type (<: AbstractSite{LS,D})
#       --> D is the dimension of embedding space
#       --> LS is the label type of sites
#   --> B is the bond type (<: AbstractBond{LB,N})
#       --> N is the dimension of the Bravais lattice that the bond is located in
#       --> LB is the label type of bonds
#
#   FILE CONTAINS
#       - abstract type definition
#       - interface definition
#       - TODO interface testing
#
################################################################################

################################################################################
#
#   ABSTRACT TYPE DEFINITION
#
################################################################################
abstract type AbstractUnitcell{
        S <: AbstractSite{LS,D} where {LS,D},
        B <: AbstractBond{LB,N} where {LB,N}
    } end

# export the type
export AbstractUnitcell


# DOCSTRING
"""
    abstract type AbstractUnitcell{S,B}

The abstract unitcell type that describes all unitcell implementations. It is parametric in two types,
- `S` the type of sites within unitcell (subtype of `AbstractSite{LS,D}`)
- `B` the type of bonds within unitcell (subtype of `AbstractBond{LB,N}`)
Note that the spatial dimension or the number of Bravais lattice vectors is already
encoded in the site and bond types respectively, as e.g. `N` describes the number of Bravais lattice vectors.

The abstract type is equipped with interface functions which are listed in the following. These interface functions have to be implemented by concrete subtypes / structs for the concrete type to be usable in all pre-implemented functions.
- `newUnitcell` to create a new unitcell object of a passed concrete unitcell type
- `latticeVectors` and `latticeVectors!` to access the Bravais lattice vectors
- `sites` and `sites!` to access the site list of the unitcell
- `bonds` and `bonds!` to access the bond list of the unitcell

The interface functions throw adequate errors when called but not implemented for concrete types.
See specific documentation for the individual functions.

Furthermore, there are certain convinience functions which do not have to be implemented for every
concrete type. These are
- `numSites` to get the number of sites (i.e. length of site list)
- `numBonds` to get the number of bonds (i.e. length of bond list)
- `site` and `bond` to explicitly access individual sites and bonds
- `organizedBondsFrom` and `organizedBondsTo` to get a reorganized form of the bond list
- `a1`, `a2` and `a3` to access individual Bravais lattice vectors directly


# Examples

`AbstractUnitcell{Site{Int64,3}, Bond{Symbol,2}}` is the supertype of a unitcell in `3` spatial dimensions with `2` Bravais lattice vectors with `Int64` site labels and `Symbol` bond labels.

"""
AbstractUnitcell



################################################################################
#
#	INTERFACING / ACCESSING UNITCELLS
#	(functions have to be overwritten by concrete types)
#
################################################################################


# default constructor interface
# used for creation of new unitcells
"""
    function newUnitcell(
            ::Type{U},
            lattice_vectors :: Vector{<:Vector{<:Real}},
            sites           :: Vector{S},
            bonds           :: Vector{B}
        ) :: U where{...}

Interface function for creation of new `AbstractUnitcell` object of a passed type `U` from a passed
set of `lattice_vectors`, `sites` and `bonds`. Returns a new unitcell object of type `U`.
Note that `sites` have to be `AbstractSite` objects and `bonds` have to be `AbstractBond` objects so that
from their types one can infere information on the unitcell.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.

NOTE that this constructor function is most commonly used in further unitcell generating
functions that build on abstract interfaces. This way, any unitcell type can be chosen
as a type for the constructed unitcell and the functions don't have to know the details
of the specific types.



# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds)
...
```
"""
function newUnitcell(
            ::Type{U},
            lattice_vectors :: Vector{<:Vector{<:Real}},
            sites           :: Vector{S},
            bonds           :: Vector{B}
        ) :: U where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'newUnitcell' for concrete unitcell type " *
            string(U) * " with bond type " * string(B) *
            " and site type " * string(S)   )
end

# export the newUnitcell interface
export newUnitcell






# accessing a list of lattice vectors
"""
    function latticeVectors(
            unitcell :: AbstractUnitcell{S,B}
        ) :: Vector{Vector{Float64}} where {...}

Interface function for obtaining the Bravais lattice vectors of a passed `AbstractUnitcell` object `unitcell`.
Returns a list of Bravais lattice vectors as an object of type `Vector{Vector{Float64}}`.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> latticeVectors(uc)
2-element Array{Array{Float64,1},1}:
 [1.0, 0.0]
 [0.0, 1.0]
```
"""
function latticeVectors(
            unitcell :: U
        ) :: Vector{Vector{Float64}} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'latticeVectors' for concrete unitcell type " * string(U) )
end
# setting a list of lattice vectors
"""
    function latticeVectors!(
            unitcell        :: AbstractUnitcell{S,B},
            lattice_vectors :: Vector{<:Vector{<:Real}}
        ) where {...}

Interface function for setting the Bravais lattice vectors of a passed `AbstractUnitcell` object `unitcell` to a new value.
Returns nothing.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> latticeVectors!(uc, [[2,0], [0,2]])

julia> latticeVectors(uc)
2-element Array{Array{Float64,1},1}:
 [2.0, 0.0]
 [0.0, 2.0]
```
"""
function latticeVectors!(
            unitcell        :: U,
            lattice_vectors :: Vector{<:Vector{<:Real}}
        ) where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'latticeVectors!' for concrete unitcell type " * string(U) )
end

# export the latticeVectors interface
export latticeVectors, latticeVectors!




# accessing a list of sites
"""
    function sites(
            unitcell :: AbstractUnitcell{S,B}
        ) :: Vector{S} where {...}

Interface function for obtaining the list of sites of a passed `AbstractUnitcell` object `unitcell`.
Returns a list of `AbstractSite` objects of type `S` as an object of type `Vector{S}`.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> sites(uc)
2-element Array{Site{String,2},1}:
 Site{Int64,2} @[0.0, 0.0]: "site1"
 Site{Int64,2} @[0.57735, 0.0]: "site2"
```
"""
function sites(
            unitcell :: U
        ) :: Vector{S} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'sites' for concrete unitcell type " *
            string(U) * " with site type " * string(S)   )
end
# setting a list of sites
"""
    function sites!(
            unitcell :: AbstractUnitcell{S,B},
            sites    :: Vector{S}
        ) where {...}

Interface function for setting the sites of a passed `AbstractUnitcell` object `unitcell` to a new value.
Returns nothing.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> sites!(uc, new_site_list)

julia> sites(uc)
2-element Array{Site{String,2},1}:
 Site{Int64,2} @[0.0, 1.0]: "site1_new"
 Site{Int64,2} @[0.1, 0.0]: "site2_new"
```
"""
function sites!(
            unitcell :: U,
            sites    :: Vector{S}
        ) where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'sites!' for concrete unitcell type " *
            string(U) * " with site type " * string(S)   )
end

# export the sites interface
export sites, sites!



# accessing a list of bonds
"""
    function bonds(
            unitcell :: AbstractUnitcell{S,B}
        ) :: Vector{B} where {...}

Interface function for obtaining the list of bonds of a passed `AbstractUnitcell` object `unitcell`.
Returns a list of `AbstractBond` objects of type `B` as an object of type `Vector{B}`.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> bonds(uc)
6-element Array{Bond{Int64,2},1}:
 Bond{Int64,2} 1-->2 @(0, 0): 1
 Bond{Int64,2} 1-->2 @(-1, 0): 1
 Bond{Int64,2} 1-->2 @(0, -1): 1
 Bond{Int64,2} 2-->1 @(0, 0): 1
 Bond{Int64,2} 2-->1 @(1, 0): 1
 Bond{Int64,2} 2-->1 @(0, 1): 1
```
"""
function bonds(
            unitcell :: U
        ) :: Vector{B} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'bonds' for concrete unitcell type " *
            string(U) * " with bond type " * string(B)   )
end
# setting a list of bonds
"""
    function bonds!(
            unitcell :: AbstractUnitcell{S,B},
            bonds    :: Vector{B}
        ) where {...}

Interface function for setting the bonds of a passed `AbstractUnitcell` object `unitcell` to a new value.
Returns nothing.

NOTE that bonds are always directed and require a returning counterpart to work as expected.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> bonds!(uc, bond_list_new)

julia> bonds(uc)
2-element Array{Bond{Int64,2},1}:
 Bond{Int64,2} 1-->2 @(0, 0): 42
 Bond{Int64,2} 2-->1 @(0, 0): 42
```
"""
function bonds!(
            unitcell :: U,
            bonds    :: Vector{B}
        ) where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'bonds!' for concrete unitcell type " *
            string(U) * " with bond type " * string(B)   )
end

# export the bonds interface
export bonds, bonds!





function saveUnitcell(
        uc :: UC,
        fn :: AbstractString,
        group :: AbstractString = "unitcell"
        ;
        append :: Bool = false
    ) where {SUC<:AbstractSite,BUC<:AbstractBond,UC<:AbstractUnitcell{SUC,BUC}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'saveUnitcell' for concrete unitcell type " * string(U) )
end

function loadUnitcell(
        ::Type{UC},
        fn :: AbstractString,
        group :: AbstractString = "unitcell"
    ) where {SUC<:AbstractSite,BUC<:AbstractBond,UC<:AbstractUnitcell{SUC,BUC}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'loadUnitcell' for concrete unitcell type " * string(U) )
end

export saveUnitcell, loadUnitcell







# SIMILAR FUNCTION (can be overwritten but does not have to be overwritten)

# without new parameters
function similar(
            u :: U
        ) where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # return a new unitcell object
    return newUnitcell(
        U,
        deepcopy(latticeVectors(u)),
        deepcopy(sites(u)),
        deepcopy(bonds(u))
    )
end
# with new parameters
function similar(
            u :: U,
            lattice_vectors :: Vector{<:Vector{<:Real}},
            sites           :: Vector{S},
            bonds           :: Vector{B}
        ) where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # create a new unitcell object
    u_new = similar(u)
    # set parameters
    latticeVectors!(u_new, lattice_vectors)
    sites!(u_new, sites)
    bonds!(u_new, bonds)
    # return the new object
    return u_new
end

# export the similar interface
export similar




# some more beauty interface
# builds on interface defined above but can also be overwritten

# number of sites
"""
    function numSites(
            unitcell :: AbstractUnitcell{S,B}
        ) :: Int64 where {...}

Function for obtaining the number of sites of a passed `AbstractUnitcell` object `unitcell`.
Returns the number as an `Int64`.

This function does not have to be overwritten by a concrete type as it is implemented
per default as the length of the site list obtained by `sites(unitcell)`.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> numSites(uc)
2
```
"""
function numSites(
            unitcell :: U
        ) :: Int64 where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # return length of the site array that the unitcell type implements
    return length(sites(unitcell))
end

# number of bonds
"""
    function numBonds(
            unitcell :: AbstractUnitcell{S,B}
        ) :: Int64 where {...}

Function for obtaining the number of bonds of a passed `AbstractUnitcell` object `unitcell`.
Returns the number as an `Int64`.

This function does not have to be overwritten by a concrete type as it is implemented
per default as the length of the bond list obtained by `bonds(unitcell)`.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> numBonds(uc)
6
```
"""
function numBonds(
            unitcell :: U
        ) :: Int64 where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # return length of the bond array that the unitcell type implements
    return length(bonds(unitcell))
end

# export the number interfaces
export numSites, numBonds




# access a specific site or bond

# site
"""
    function site(
            unitcell :: AbstractUnitcell{S,B},
            index    :: Integer
        ) :: S where {...}

Function for obtaining the `AbstractSite` object of type `S` that corresponds to the site with index `index`
of a passed `AbstractUnitcell` object `unitcell`. Returns an object of type `S`.

This function does not have to be overwritten by a concrete type as it is implemented
per default as explicit call from the site list obtained by `sites(unitcell)`.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> site(uc,1)
Site{Int64,2} @[0.0, 0.0]: "site1"
```
"""
function site(
            unitcell :: U,
            index    :: Integer
        ) :: S where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # return the respective site
    return sites(unitcell)[index]
end

# bond
"""
    function bond(
            unitcell :: AbstractUnitcell{S,B},
            index    :: Integer
        ) :: B where {...}

Function for obtaining the `AbstractBond` object of type `B` that corresponds to the bond with index `index`
of a passed `AbstractUnitcell` object `unitcell`. Returns an object of type `B`.

This function does not have to be overwritten by a concrete type as it is implemented
per default as explicit call from the bond list obtained by `bonds(unitcell)`.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> bond(uc,1)
Bond{Int64,2} 1-->2 @(0, 0): 1
```
"""
function bond(
            unitcell :: U,
            index    :: Integer
        ) :: B where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # return the respective bond
    return bonds(unitcell)[index]
end

# export the specific site and bond interfaces
export site, bond




# get an organized bond list (organized by 'from')
"""
    function organizedBondsFrom(
            unitcell :: AbstractUnitcell{S,B}
        ) :: Vector{Vector{B}} where {...}

Function for obtaining an organized version of the list of bonds of a passed `AbstractUnitcell` object `unitcell`.
Returns a nested list of `AbstractBond` objects of type `B` as an object of type `Vector{Vector{B}}`,
in which the element `i` is a list of all bonds emerging from site `i`.

This function does not have to be overwritten by a concrete type as it is implemented
on the level of abstract types and interface functions.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> organizedBondsFrom(uc)
2-element Array{Array{Bond{Int64,2},1},1}:
 [Bond{Int64,2} 1-->2 @(0, 0): 1, Bond{Int64,2} 1-->2 @(-1, 0): 1, Bond{Int64,2} 1-->2 @(0, -1): 1]
 [Bond{Int64,2} 2-->1 @(0, 0): 1, Bond{Int64,2} 2-->1 @(1, 0): 1, Bond{Int64,2} 2-->1 @(0, 1): 1]
```
"""
function organizedBondsFrom(
            unitcell :: U
        ) :: Vector{Vector{B}} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # temporary fix for dispatch behavior: name all types explicitly
    D,N,LS,LB,U,S,B
    # construct a list of indices
    indices  = zeros(Int64, numBonds(unitcell))
    list_len = zeros(Int64, numSites(unitcell))
    # give each bond an index
    for b in 1:numBonds(unitcell)
        list_len[from(bond(unitcell,b))] += 1
        indices[b] = list_len[from(bond(unitcell,b))]
    end
    # create all lists
    organized_bonds = Vector{Vector{B}}(undef, numSites(unitcell))
    for s in 1:numSites(unitcell)
        organized_bonds[s] = Vector{B}(undef, list_len[s])
    end
    # insert all bonds
    for b in 1:numBonds(unitcell)
        organized_bonds[from(bond(unitcell,b))][indices[b]] = bond(unitcell,b)
    end
    # return the list
    return organized_bonds
end
# get an organized bond list (organized by 'to')
"""
    function organizedBondsTo(
            unitcell :: AbstractUnitcell{S,B}
        ) :: Vector{Vector{B}} where {...}

Function for obtaining an organized version of the list of bonds of a passed `AbstractUnitcell` object `unitcell`.
Returns a nested list of `AbstractBond` objects of type `B` as an object of type `Vector{Vector{B}}`,
in which the element `i` is a list of all bonds pointing to site `i`.

This function does not have to be overwritten by a concrete type as it is implemented
on the level of abstract types and interface functions.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0], [0,1]], sites, bonds);

julia> organizedBondsTo(uc)
2-element Array{Array{Bond{Int64,2},1},1}:
 [Bond{Int64,2} 2-->1 @(0, 0): 1, Bond{Int64,2} 2-->1 @(1, 0): 1, Bond{Int64,2} 2-->1 @(0, 1): 1]
 [Bond{Int64,2} 1-->2 @(0, 0): 1, Bond{Int64,2} 1-->2 @(-1, 0): 1, Bond{Int64,2} 1-->2 @(0, -1): 1]
```
"""
function organizedBondsTo(
            unitcell :: U
        ) :: Vector{Vector{B}} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # temporary fix for dispatch behavior: name all types explicitly
    D,N,LS,LB,U,S,B
    # construct a list of indices
    indices  = zeros(Int64, numBonds(unitcell))
    list_len = zeros(Int64, numSites(unitcell))
    # give each bond an index
    for b in 1:numBonds(unitcell)
        list_len[to(bond(unitcell,b))] += 1
        indices[b] = list_len[to(bond(unitcell,b))]
    end
    # create all lists
    organized_bonds = Vector{Vector{B}}(undef, numSites(unitcell))
    for s in 1:numSites(unitcell)
        organized_bonds[s] = Vector{B}(undef, list_len[s])
    end
    # insert all bonds
    for b in 1:numBonds(unitcell)
        organized_bonds[to(bond(unitcell,b))][indices[b]] = bond(unitcell,b)
    end
    # return the list
    return organized_bonds
end

# export organized bond function
export organizedBondsFrom, organizedBondsTo


# specific Bravais lattices

# a1
"""
    function a1(unitcell ::AbstractUnitcell{S,B}) ::Vector{Float64} where {...}

Function for directly obtaining the first Bravais lattice vector of a passed `AbstractUnitcell` object `unitcell`.
Returns the vector as an object of type `Vector{Float64}`.

This function does not have to be overwritten by a concrete type as it is implemented
as a simple wrapper around `latticeVectors(unitcell)`.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0,0], [0,1,0], [0,0,1]], sites, bonds);

julia> a1(uc)
[1,0,0]
```
"""
function a1(
            unitcell :: U
        ) :: Vector{Float64} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # return the first entry in the lattice vectors list
    return latticeVectors(unitcell)[1]
end

# a2
"""
    function a2(unitcell ::AbstractUnitcell{S,B}) ::Vector{Float64} where {...}

Function for directly obtaining the second Bravais lattice vector of a passed `AbstractUnitcell` object `unitcell`.
Returns the vector as an object of type `Vector{Float64}`.

This function does not have to be overwritten by a concrete type as it is implemented
as a simple wrapper around `latticeVectors(unitcell)`.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0,0], [0,1,0], [0,0,1]], sites, bonds);

julia> a2(uc)
[0,1,0]
```
"""
function a2(
            unitcell :: U
        ) :: Vector{Float64} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # return the second entry in the lattice vectors list
    return latticeVectors(unitcell)[2]
end

# a3
"""
    function a3(unitcell ::AbstractUnitcell{S,B}) ::Vector{Float64} where {...}

Function for directly obtaining the third Bravais lattice vector of a passed `AbstractUnitcell` object `unitcell`.
Returns the vector as an object of type `Vector{Float64}`.

This function does not have to be overwritten by a concrete type as it is implemented
as a simple wrapper around `latticeVectors(unitcell)`.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0,0], [0,1,0], [0,0,1]], sites, bonds);

julia> a3(uc)
[0,0,1]
```
"""
function a3(
            unitcell :: U
        ) :: Vector{Float64} where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}

    # return the third entry in the lattice vectors list
    return latticeVectors(unitcell)[3]
end

# export the Bravais lattice interfaces
export a1, a2, a3





# Syntax for directly obtaining a connecting vector

# Fallback (error) for non-fitting pairs & DOCTSTRING
"""
    function vector(b::AbstractBond, u::AbstractUnitcell) ::Vector{Float64} where {...}

Function for directly obtaining the vector that describes the bond `b` in real space.
Unitcell object `u` is necessary to pass since it contains site and lattice vector information.


# Examples

```julia-REPL
julia> uc = newUnitcell(Unitcell{Site{String,2}, Bond{Int64,2}}, [[1,0,0], [0,1,0], [0,0,1]], sites, bonds);

julia> vector(newBond(Bond{String,3}, 1,1, "mybond", (1,0,0)), uc)
[1.0, 0.0, 0.0]
```
"""
function vector(
            bond     :: B,
            unitcell :: U
        ) :: Vector{Float64} where {N,L,B<:AbstractBond{L,N}, S,NU,LU,BU<:AbstractBond{LU,NU},U<:AbstractUnitcell{S,BU}}

    # throw an error
    @error "unitcell and bond are not fitting"
end

# 0d
function vector(
            bond     :: B,
            unitcell :: U
        ) :: Vector{Float64} where {L,B<:AbstractBond{L,0}, S,LU,BU<:AbstractBond{LU,0},U<:AbstractUnitcell{S,BU}}

    # return the offset vector
    return (
        point(site(unitcell,to(bond))) .- point(site(unitcell,from(bond)))
    )
end

# 1d
function vector(
            bond     :: B,
            unitcell :: U
        ) :: Vector{Float64} where {L,B<:AbstractBond{L,1}, S,LU,BU<:AbstractBond{LU,1},U<:AbstractUnitcell{S,BU}}

    # return the offset vector
    return (
        point(site(unitcell,to(bond))) .- point(site(unitcell,from(bond))) .+
        wrap(bond)[1].*a1(unitcell)
    )
end

# 2d
function vector(
            bond     :: B,
            unitcell :: U
        ) :: Vector{Float64} where {L,B<:AbstractBond{L,2}, S,LU,BU<:AbstractBond{LU,2},U<:AbstractUnitcell{S,BU}}

    # return the offset vector
    return (
        point(site(unitcell,to(bond))) .- point(site(unitcell,from(bond))) .+
        wrap(bond)[1].*a1(unitcell) .+ wrap(bond)[2].*a2(unitcell)
    )
end

# 3d
function vector(
            bond     :: B,
            unitcell :: U
        ) :: Vector{Float64} where {L,B<:AbstractBond{L,3}, S,LU,BU<:AbstractBond{LU,3},U<:AbstractUnitcell{S,BU}}

    # return the offset vector
    return (
        point(site(unitcell,to(bond))) .- point(site(unitcell,from(bond))) .+
        wrap(bond)[1].*a1(unitcell) .+ wrap(bond)[2].*a2(unitcell) .+ wrap(bond)[3].*a3(unitcell)
    )
end

# Nd
function vector(
            bond     :: B,
            unitcell :: U
        ) :: Vector{Float64} where {N,L,B<:AbstractBond{L,N}, S,LU,BU<:AbstractBond{LU,N},U<:AbstractUnitcell{S,BU}}

    # build the offset vector
    v = point(site(unitcell,to(bond))) .- point(site(unitcell,from(bond)))
    for i in 1:N
        v .+= wrap(bond)[i].*latticeVectors(unitcell)[i]
    end
    # return the offset vector
    return v
end

# export the function
export vector

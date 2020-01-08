################################################################################
#
#	ABSTRACT TYPE
#
#   Lattice{S,B,U}
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
abstract type AbstractLattice{
        S <: AbstractSite{LS,D} where {LS,D},
        B <: AbstractBond{LB,N} where {LB,N},
        U <: AbstractUnitcell{SU,BU} where {
            SU <: AbstractSite{LUS,DU} where {LUS,DU},
            BU <: AbstractBond{LUB,NU} where {LUB,NU},
        }
    } end

# export the type
export AbstractLattice


# DOCSTRING
"""
    abstract type AbstractLattice{S,B,U}

The abstract unitcell type that describes all unitcell implementations.
It is parametric in three types,
- `S` the type of sites within lattice (subtype of `AbstractSite{LS,D}`)
- `B` the type of bonds within lattice (subtype of `AbstractBond{LB,N}`)
- `U` the type of unitcell within lattice (subtype of `AbstractUnitcell{S,B}`). Note that the site and bond types of the unitcell can be different from that of the lattice.
Note that the spatial dimension or the number of Bravais lattice vectors is already
encoded in the site and bond types respectively, as e.g. `N` describes the
number of Bravais lattice vectors.

The abstract type is equipped with interface functions which are listed in the following.
These interface functions have to be implemented by concrete subtypes / structs for the
concrete type to be usable in all pre-implemented functions.
- `newLattice` to create a new lattice object of a passed concrete lattice type
- `latticeVectors` and `latticeVectors!` to access the Bravais lattice vectors
- `sites` and `sites!` to access the site list of the lattice
- `bonds` and `bonds!` to access the bond list of the lattice
- `unitcell` and `unitcell!` to access the unitcell of the lattice

The interface functions throw adequate errors when called but not implemented for
concrete types. See specific documentation for the individual functions.

Furthermore, there are certain convinience functions which do not have to be implemented for every
concrete type. These are
- `numSites` to get the number of sites (i.e. length of site list)
- `numBonds` to get the number of bonds (i.e. length of bond list)
- `site` and `bond` to explicitly access individual sites and bonds
- `organizedBondsFrom` and `organizedBondsTo` to get a reorganized form of the bond list
- `a1`, `a2` and `a3` to access individual Bravais lattice vectors directly


# Examples

`AbstractLattice{Site{Int64,3}, Bond{Int64,2}, Unitcell{Site{Int64,3}, Bond{Symbol,2}}}`
is the supertype of a lattice in `3` spatial dimensions with `2` Bravais lattice vectors with
`Int64` site labels and `Int64` bond labels and a unitcell in `3` spatial dimensions with `2`
Bravais lattice vectors with `Int64` site labels and `Symbol` bond labels.

"""
AbstractLattice


"""
Number of spatial dimensions the lattice is embedded in.
"""
Base.ndims(l::AbstractLattice{S}) where S<:AbstractSite = ndims(S)


################################################################################
#
#	INTERFACING / ACCESSING LATTICES
#	(functions have to be overwritten by concrete types)
#
################################################################################


# default constructor interface
# used for creation of new lattices
"""
    function newLattice(
            ::Type{L},
            lattice_vectors :: Vector{<:Vector{<:Real}},
            sites           :: Vector{S},
            bonds           :: Vector{B},
            unitcell        :: U
        ) :: L where{...}

Interface function for creation of new `AbstractLattice` object of a passed type `L` from a passed
set of `lattice_vectors`, `sites`, `bonds` and a `unitcell`. Returns a new lattice object of type `L`.
Note that `sites` have to be `AbstractSite` objects and `bonds` have to be `AbstractBond` objects so that
from their types one can infere information on the lattice. Furthermore, the lattice type has to be specified
to agree with the types of `S`, `B` and `U`.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.

NOTE that this constructor function is most commonly used in further lattice constructing
functions that build on abstract interfaces. This way, any lattice type can be chosen
as a type for the constructed lattice and the functions don't have to know the details
of the specific types.


# Examples

```julia-REPL
julia> lt = newLattice(
                Lattice{Site{String,2}, Bond{Int64,2}, Unitcell{Site{String,2}, Bond{Int64,2}}},
                lattice_vectors,
                sites,
                bonds,
                unitcell
            )
...
```
"""
function newLattice(
            ::Type{L},
            lattice_vectors :: Vector{<:Vector{<:Real}},
            sites           :: Vector{S},
            bonds           :: Vector{B},
            unitcell        :: U
        ) :: L where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'newLattice' for concrete lattice type " *
            string(L) * " with bond type " * string(B) *
            " and site type " * string(S)   )
end

# export the newLattice interface
export newLattice




# accessing a list of lattice vectors
"""
    function latticeVectors(
            lattice :: AbstractLattice{S,B,U}
        ) :: Vector{Vector{Float64}} where {...}

Interface function for obtaining the Bravais lattice vectors of a passed `AbstractLattice` object `lattice`.
Returns a list of Bravais lattice vectors as an object of type `Vector{Vector{Float64}}`.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> latticeVectors(lattice)
2-element Array{Array{Float64,1},1}:
 [1.0, 0.0]
 [0.0, 1.0]
```
"""
function latticeVectors(
            lattice :: L
        ) :: Vector{Vector{Float64}} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'latticeVectors' for concrete lattice type " * string(L) )
end
# setting a list of lattice vectors
"""
    function latticeVectors!(
            lattice         :: AbstractLattice{S,B,U},
            lattice_vectors :: Vector{<:Vector{<:Real}}
        ) where {...}

Interface function for setting the Bravais lattice vectors of a passed `AbstractLattice` object `lattice` to a new value.
Returns nothing.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> latticeVectors!(lattice, [[2,0], [0,2]])

julia> latticeVectors(lattice)
2-element Array{Array{Float64,1},1}:
 [2.0, 0.0]
 [0.0, 2.0]
```
"""
function latticeVectors!(
            lattice         :: L,
            lattice_vectors :: Vector{<:Vector{<:Real}}
        ) where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'latticeVectors!' for concrete lattice type " * string(L) )
end

# export the latticeVectors interface
export latticeVectors, latticeVectors!




# accessing a list of sites
"""
    function sites(
            lattice :: AbstractLattice{S,B,U}
        ) :: Vector{S} where {...}

Interface function for obtaining the list of sites of a passed `AbstractLattice` object `lattice`.
Returns a list of `AbstractSite` objects of type `S` as an object of type `Vector{S}`.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> sites(lattice)
20-element Array{Site{String,2},1}:
 Site{Int64,2} @[0.0, 0.0]: "site1"
 Site{Int64,2} @[0.57735, 0.0]: "site2"
 ...
```
"""
function sites(
            lattice :: L
        ) :: Vector{S} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'sites' for concrete lattice type " *
            string(L) * " with site type " * string(S)   )
end
# setting a list of sites
"""
    function sites!(
            lattice :: AbstractLattice{S,B,U},
            sites   :: Vector{S}
        ) where {...}

Interface function for setting the sites of a passed `AbstractLattice` object `lattice` to a new value.
Returns nothing.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> sites!(lattice, new_site_list)

julia> sites(lattice)
10-element Array{Site{String,2},1}:
 Site{Int64,2} @[0.0, 1.0]: "site1_new"
 Site{Int64,2} @[0.1, 0.0]: "site2_new"
 ...
```
"""
function sites!(
            lattice :: L,
            sites   :: Vector{S}
        ) where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'sites!' for concrete lattice type " *
            string(L) * " with site type " * string(S)   )
end

# export the sites interface
export sites, sites!



# accessing a list of bonds
"""
    function bonds(
            lattice :: AbstractLattice{S,B,U}
        ) :: Vector{B} where {...}

Interface function for obtaining the list of bonds of a passed `AbstractLattice` object `lattice`.
Returns a list of `AbstractBond` objects of type `B` as an object of type `Vector{B}`.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> bonds(lattice)
60-element Array{Bond{Int64,2},1}:
 Bond{Int64,2} 1-->2 @(0, 0): 1
 Bond{Int64,2} 2-->1 @(0, 0): 1
 ...
```
"""
function bonds(
            lattice :: L
        ) :: Vector{B} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'bonds' for concrete lattice type " *
            string(L) * " with bond type " * string(B)   )
end
# setting a list of bonds
"""
    function bonds!(
            lattice :: AbstractLattice{S,B,U},
            bonds   :: Vector{B}
        ) where {...}

Interface function for setting the bonds of a passed `AbstractLattice` object `lattice` to a new value.
Returns nothing.

NOTE that bonds are always directed and require a returning counterpart to work as expected.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> bonds!(lattice, bond_list_new)

julia> bonds(uc)
20-element Array{Bond{Int64,2},1}:
 Bond{Int64,2} 1-->2 @(0, 1): 42
 Bond{Int64,2} 2-->1 @(0, -1): 42
 ...
```
"""
function bonds!(
            lattice :: L,
            bonds   :: Vector{B}
        ) where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'bonds!' for concrete lattice type " *
            string(L) * " with bond type " * string(B)   )
end

# export the bonds interface
export bonds, bonds!




# accessing the unitcell
"""
    function unitcell(
            lattice :: AbstractLattice{S,B,U}
        ) :: U where {...}

Interface function for obtaining the unitcell of a passed `AbstractLattice` object `lattice`.
Returns an object of type `U`.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> unitcell(lattice)
...
```
"""
function unitcell(
            lattice :: L
        ) :: U where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'unitcell' for concrete lattice type " *
            string(L) * " with unitcell type " * string(U)   )
end
# setting the unitcell
"""
    function unitcell(
            lattice  :: AbstractLattice{S,B,U},
            unitcell :: U
        ) :: U where {...}

Interface function for setting the unitcell of a passed `AbstractLattice` object `lattice`
to a new `AbstractUnitcell` object `unitcell` of type `U`.
Returns nothing.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> unitcell!(lattice, uc)
...
```
"""
function unitcell!(
            lattice  :: L,
            unitcell :: U
        ) where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'unitcell!' for concrete lattice type " *
            string(L) * " with unitcell type " * string(U)   )
end

# export the unitcell interface
export unitcell, unitcell!










function saveLattice(
        lt :: L,
        fn :: AbstractString,
        group :: AbstractString = "lattice"
        ;
        append :: Bool = false
    ) where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'saveLattice' for concrete lattice type " *
            string(L) * " with unitcell type " * string(U)   )
end

function loadLattice(
        ::Type{L},
        fn :: AbstractString,
        group :: AbstractString = "lattice"
    ) :: L where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'loadLattice' for concrete lattice type " *
            string(L) * " with unitcell type " * string(U)   )
end

export saveLattice, loadLattice










# SIMILAR FUNCTION (can be overwritten but does not have to be overwritten)

# without new parameters
function similar(
            l :: L
        ) where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # return a new lattice object
    return newLattice(
        L,
        deepcopy(latticeVectors(l)),
        deepcopy(sites(l)),
        deepcopy(bonds(l)),
        deepcopy(unitcell(l))
    )
end
# with new parameters
function similar(
            l :: L,
            lattice_vectors :: Vector{<:Vector{<:Real}},
            sites           :: Vector{S},
            bonds           :: Vector{B},
            unitcell        :: U
        ) where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # create a new lattice object
    l_new = similar(l)
    # set parameters
    latticeVectors!(l_new, lattice_vectors)
    sites!(l_new, sites)
    bonds!(l_new, bonds)
    unitcell!(l_new, unitcell)
    # return the new object
    return l_new
end

# export the similar interface
export similar





# some more beauty interface
# builds on interface defined above but can also be overwritten

# number of sites
"""
    function numSites(
            lattice  :: AbstractLattice{S,B,U}
        ) :: Int64 where {...}

Function for obtaining the number of sites of a passed `AbstractLattice` object `lattice`.
Returns the number as an `Int64`.

This function does not have to be overwritten by a concrete type as it is implemented
per default as the length of the site list obtained by `sites(lattice)`.


# Examples

```julia-REPL
julia> numSites(lattice)
20
```
"""
function numSites(
            lattice :: L
        ) :: Int64 where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # return length of the site array that the lattice type implements
    return length(sites(lattice))
end

# number of bonds
"""
    function numBonds(
            lattice  :: AbstractLattice{S,B,U}
        ) :: Int64 where {...}

Function for obtaining the number of bonds of a passed `AbstractLattice` object `lattice`.
Returns the number as an `Int64`.

This function does not have to be overwritten by a concrete type as it is implemented
per default as the length of the bond list obtained by `bonds(lattice)`.


# Examples

```julia-REPL
julia> numBonds(lattice)
60
```
"""
function numBonds(
            lattice :: L
        ) :: Int64 where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # return length of the bond array that the lattice type implements
    return length(bonds(lattice))
end

# export the number interfaces
export numSites, numBonds






# access a specific site or bond

# site
"""
    function site(
            lattice :: AbstractLattice{S,B,U},
            index   :: Integer
        ) :: S where {...}

Function for obtaining the `AbstractSite` object of type `S` that corresponds to the site with index `index`
of a passed `AbstractLattice` object `lattice`. Returns an object of type `S`.

This function does not have to be overwritten by a concrete type as it is implemented
per default as explicit call from the site list obtained by `sites(lattice)`.


# Examples

```julia-REPL
julia> site(lattice,1)
Site{Int64,2} @[0.0, 0.0]: "site1"
```
"""
function site(
            lattice :: L,
            index   :: Int64
        ) :: S where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # return the respective site
    return sites(lattice)[index]
end

# bond
"""
    function bond(
            lattice :: AbstractLattice{S,B,U},
            index   :: Integer
        ) :: B where {...}

Function for obtaining the `AbstractBond` object of type `B` that corresponds to the bond with index `index`
of a passed `AbstractLattice` object `lattice`. Returns an object of type `B`.

This function does not have to be overwritten by a concrete type as it is implemented
per default as explicit call from the bond list obtained by `bonds(lattice)`.


# Examples

```julia-REPL
julia> bond(lattice,1)
Bond{Int64,2} 1-->2 @(0, 0): 1
```
"""
function bond(
            lattice :: L,
            index   :: Int64
        ) :: B where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # return the respective bond
    return bonds(lattice)[index]
end

# export the specific site and bond interfaces
export site, bond





# get an organized bond list (organized by 'from')
"""
    function organizedBondsFrom(
            lattice :: AbstractLattice{S,B,U}
        ) :: Vector{Vector{B}} where {...}

Function for obtaining an organized version of the list of bonds of a passed `AbstractLattice` object `lattice`.
Returns a nested list of `AbstractBond` objects of type `B` as an object of type `Vector{Vector{B}}`,
in which the element `i` is a list of all bonds emerging from site `i`.

This function does not have to be overwritten by a concrete type as it is implemented
on the level of abstract types and interface functions.


# Examples

```julia-REPL
julia> organizedBondsFrom(lattice)
20-element Array{Array{Bond{Int64,2},1},1}:
 [Bond{Int64,2} 1-->2 @(0, 0): 1, Bond{Int64,2} 1-->2 @(-1, 0): 1, Bond{Int64,2} 1-->2 @(0, -1): 1]
 [Bond{Int64,2} 2-->1 @(0, 0): 1, Bond{Int64,2} 2-->1 @(1, 0): 1, Bond{Int64,2} 2-->1 @(0, 1): 1]
 ...
```
"""
function organizedBondsFrom(
            lattice :: L
        ) :: Vector{Vector{B}} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # temporary fix for dispatch behavior: name all types explicitly
    D,N,LS,LB,U,S,B,L
    # construct a list of indices
    indices  = zeros(Int64, numBonds(lattice))
    list_len = zeros(Int64, numSites(lattice))
    # give each bond an index
    for b in 1:numBonds(lattice)
        list_len[from(bond(lattice,b))] += 1
        indices[b] = list_len[from(bond(lattice,b))]
    end
    # create all lists
    organized_bonds = Vector{Vector{B}}(undef, numSites(lattice))
    for s in 1:numSites(lattice)
        organized_bonds[s] = Vector{B}(undef, list_len[s])
    end
    # insert all bonds
    for b in 1:numBonds(lattice)
        organized_bonds[from(bond(lattice,b))][indices[b]] = bond(lattice,b)
    end
    # return the list
    return organized_bonds
end
# get an organized bond list (organized by 'to')
"""
    function organizedBondsTo(
            lattice :: AbstractLattice{S,B,U}
        ) :: Vector{Vector{B}} where {...}

Function for obtaining an organized version of the list of bonds of a passed `AbstractLattice` object `lattice`.
Returns a nested list of `AbstractBond` objects of type `B` as an object of type `Vector{Vector{B}}`,
in which the element `i` is a list of all bonds pointing to site `i`.

This function does not have to be overwritten by a concrete type as it is implemented
on the level of abstract types and interface functions.


# Examples

```julia-REPL
julia> organizedBondsTo(lattice)
2-element Array{Array{Bond{Int64,2},1},1}:
 [Bond{Int64,2} 2-->1 @(0, 0): 1, Bond{Int64,2} 2-->1 @(1, 0): 1, Bond{Int64,2} 2-->1 @(0, 1): 1]
 [Bond{Int64,2} 1-->2 @(0, 0): 1, Bond{Int64,2} 1-->2 @(-1, 0): 1, Bond{Int64,2} 1-->2 @(0, -1): 1]
 ...
```
"""
function organizedBondsTo(
            lattice :: L
        ) :: Vector{Vector{B}} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # temporary fix for dispatch behavior: name all types explicitly
    D,N,LS,LB,U,S,B,L
    # construct a list of indices
    indices  = zeros(Int64, numBonds(lattice))
    list_len = zeros(Int64, numSites(lattice))
    # give each bond an index
    for b in 1:numBonds(lattice)
        list_len[to(bond(lattice,b))] += 1
        indices[b] = list_len[to(bond(lattice,b))]
    end
    # create all lists
    organized_bonds = Vector{Vector{B}}(undef, numSites(lattice))
    for s in 1:numSites(lattice)
        organized_bonds[s] = Vector{B}(undef, list_len[s])
    end
    # insert all bonds
    for b in 1:numBonds(lattice)
        organized_bonds[to(bond(lattice,b))][indices[b]] = bond(lattice,b)
    end
    # return the list
    return organized_bonds
end

# export organized bond function
export organizedBondsFrom, organizedBondsTo



# specific Bravais lattices

# a1
"""
    function a1(lattice ::AbstractLattice{S,B,U}) ::Vector{Float64} where {...}

Function for directly obtaining the first Bravais lattice vector of a passed `AbstractLattice` object `lattice`.
Returns the vector as an object of type `Vector{Float64}`.

This function does not have to be overwritten by a concrete type as it is implemented
as a simple wrapper around `latticeVectors(lattice)`.


# Examples

```julia-REPL
julia> a1(lattice)
[1,0,0]
```
"""
function a1(
            lattice :: L
        ) :: Vector{Float64} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # return the first entry in the lattice vectors list
    return latticeVectors(lattice)[1]
end

# a2
"""
    function a2(lattice ::AbstractLattice{S,B,U}) ::Vector{Float64} where {...}

Function for directly obtaining the second Bravais lattice vector of a passed `AbstractLattice` object `lattice`.
Returns the vector as an object of type `Vector{Float64}`.

This function does not have to be overwritten by a concrete type as it is implemented
as a simple wrapper around `latticeVectors(lattice)`.


# Examples

```julia-REPL
julia> a2(lattice)
[0,1,0]
```
"""
function a2(
            lattice :: L
        ) :: Vector{Float64} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # return the second entry in the lattice vectors list
    return latticeVectors(lattice)[2]
end

# a3
"""
    function a3(lattice ::AbstractLattice{S,B,U}) ::Vector{Float64} where {...}

Function for directly obtaining the third Bravais lattice vector of a passed `AbstractLattice` object `lattice`.
Returns the vector as an object of type `Vector{Float64}`.

This function does not have to be overwritten by a concrete type as it is implemented
as a simple wrapper around `latticeVectors(lattice)`.


# Examples

```julia-REPL
julia> a3(lattice)
[0,0,1]
```
"""
function a3(
            lattice :: L
        ) :: Vector{Float64} where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}

    # return the third entry in the lattice vectors list
    return latticeVectors(lattice)[3]
end

# export the Bravais lattice interfaces
export a1, a2, a3




# Syntax for directly obtaining a connecting vector

# Fallback (error) for non-fitting pairs & DOCTSTRING
"""
    function vector(b::AbstractBond, l::AbstractLattice) ::Vector{Float64} where {...}

Function for directly obtaining the vector that describes the bond `b` in real space.
Lattice object `l` is necessary to pass since it contains site and lattice vector information.


# Examples

```julia-REPL
julia> vector(newBond(Bond{String,3}, 1,1, "mybond", (1,0,0)), mylattice)
[1.0, 0.0, 0.0]
```
"""
function vector(
            bond    :: B,
            lattice :: LA
        ) :: Vector{Float64} where {N,L,B<:AbstractBond{L,N}, SU,BU,U<:AbstractUnitcell{SU,BU}, SL,LL,NL,BL<:AbstractBond{LL,NL},LA<:AbstractLattice{SL,BL,U}}

    # throw an error
    @error "unitcell and bond are not fitting"
end

# 0d
function vector(
            bond    :: B,
            lattice :: LA
        ) :: Vector{Float64} where {L,B<:AbstractBond{L,0}, SU,BU,U<:AbstractUnitcell{SU,BU}, SL,LL,BL<:AbstractBond{LL,0},LA<:AbstractLattice{SL,BL,U}}

    # return the offset vector
    return (
        point(site(lattice,to(bond))) .- point(site(lattice,from(bond)))
    )
end

# 1d
function vector(
            bond    :: B,
            lattice :: LA
        ) :: Vector{Float64} where {L,B<:AbstractBond{L,1}, SU,BU,U<:AbstractUnitcell{SU,BU}, SL,LL,BL<:AbstractBond{LL,1},LA<:AbstractLattice{SL,BL,U}}

    # return the offset vector
    return (
        point(site(lattice,to(bond))) .- point(site(lattice,from(bond))) .+
        wrap(bond)[1].*a1(lattice)
    )
end

# 2d
function vector(
            bond    :: B,
            lattice :: LA
        ) :: Vector{Float64} where {L,B<:AbstractBond{L,2}, SU,BU,U<:AbstractUnitcell{SU,BU}, SL,LL,BL<:AbstractBond{LL,2},LA<:AbstractLattice{SL,BL,U}}

    # return the offset vector
    return (
        point(site(lattice,to(bond))) .- point(site(lattice,from(bond))) .+
        wrap(bond)[1].*a1(lattice) .+ wrap(bond)[2].*a2(lattice)
    )
end

# 3d
function vector(
            bond    :: B,
            lattice :: LA
        ) :: Vector{Float64} where {L,B<:AbstractBond{L,3}, SU,BU,U<:AbstractUnitcell{SU,BU}, SL,LL,BL<:AbstractBond{LL,3},LA<:AbstractLattice{SL,BL,U}}

    # return the offset vector
    return (
        point(site(lattice,to(bond))) .- point(site(lattice,from(bond))) .+
        wrap(bond)[1].*a1(lattice) .+ wrap(bond)[2].*a2(lattice) .+ wrap(bond)[3].*a3(lattice)
    )
end

# Nd
function vector(
            bond    :: B,
            lattice :: LA
        ) :: Vector{Float64} where {N,L,B<:AbstractBond{L,N}, SU,BU,U<:AbstractUnitcell{SU,BU}, SL,LL,BL<:AbstractBond{LL,N},LA<:AbstractLattice{SL,BL,U}}

    # build the offset vector
    v = point(site(lattice,to(bond))) .- point(site(lattice,from(bond)))
    for i in 1:N
        v .+= wrap(bond)[i].*latticeVectors(lattice)[i]
    end
    # return the offset vector
    return v
end

# export the function
export vector

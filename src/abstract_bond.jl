################################################################################
#
#	ABSTRACT TYPE
#
#   Bond{L,N}
#   --> L is the label type
#   --> N is the dimension of the Bravais lattice that the bond is located in
#
#   FILE CONTAINS
#       - abstract type definition
#       - interface definition
#       - interface testing
#
################################################################################





################################################################################
#
#   ABSTRACT TYPE DEFINITION
#
################################################################################
abstract type AbstractBond{L,N} end

# export the type
export AbstractBond



# DOCSTRING
"""
    abstract type AbstractBond{L,N}

The abstract bond type that describes all bond implementations. It is parametric in two types,
- `L` the type of the bond label
- `N` an integer number specifying the number of periodic directions, it can wrap around


The abstract type is equipped with interface functions which are listed in the following. These interface functions have to be implemented by concrete subtypes / structs for the concrete type to be usable in all pre-implemented functions.
- `newBond` to create a new bond object of a passed concrete bond type
- `from` and `from!` to access the index of the bond origin site
- `to` and `to!` to access the index of the bond destination site
- `label` and `label!` to access the bond label
- `wrap` and `wrap!` to access the bond wrap, i.e. in which copy of the unitcell / lattice is points to

The interface functions throw adequate errors when called but not implemented for concrete types.
See specific documentation for the individual functions.

Furthermore, there is a function to test if the bond is periodic (i.e. wrapping around in any direction),
called `isPeriodic`, which does not have to be implemented for every concrete bond type.


# Examples

```julia-REPL
julia> AbstractBond{Int64,2} <: AbstractBond{L,N} where{L,N}
true
```

"""
AbstractBond





################################################################################
#
#	INTERFACING / ACCESSING BONDS
#	(functions have to be overwritten by concrete types)
#
################################################################################

# default constructor interface
# used for creation of new bonds
function newBond(
            :: Type{B},
            from    :: Integer,
            to      :: Integer,
            label   :: L,
            wrap    :: NTuple{N,<:Integer}
        ) :: B where {L,N,B<:AbstractBond{L,N}}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'newBond' for concrete bond type " *
            string(B) * " with label type " * string(L) *
            " and wrap length " * string(N)   )
end

# export the from newBond interface
export newBond




# UIDs of sites between which the bond is located

# get from index / UID (Int64)
function from(
            b :: AbstractBond{L,N}
        ) :: Int64 where {L,N}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'from' for bond type " * string(typeof(b)))
end
# set from index / UID (Int64)
function from!(
            b :: AbstractBond{L,N},
            i :: Integer
        ) where {L,N}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'from!' for bond type " * string(typeof(b)))
end

# export the from index interface
export from, from!



# get to index / UID (Int64)
function to(
            b :: AbstractBond{L,N}
        ) :: Int64 where {L,N}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'to' for bond type " * string(typeof(b)))
end
# set to index / UID (Int64)
function to!(
            b :: AbstractBond{L,N},
            i :: Integer
        ) where {L,N}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'to!' for bond type " * string(typeof(b)))
end

# export the to index interface
export to, to!




# get label
function label(
            b :: AbstractBond{L,N}
        ) :: L where {L,N}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'label' for bond type " * string(typeof(b)))
end

# set label
function label!(
            b :: AbstractBond{L,N},
            l :: L
        ) where {L,N}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'label!' for bond type " * string(typeof(b)))
end

# export the label interface
export label, label!



# get wrap
function wrap(
            b :: AbstractBond{L,N}
        ) :: NTuple{N,Int64} where {L,N}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'wrap' for bond type " * string(typeof(b)))
end
# set wrap
function wrap!(
            b :: AbstractBond{L,N},
            w :: NTuple{N, <:Integer}
        ) where {L,N}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'wrap!' for bond type " * string(typeof(b)))
end

# export the wrap interface
export wrap, wrap!




# SIMILAR FUNCTION (can be overwritten but does not have to be overwritten)

# without new parameters
function similar(
            b :: B
        ) :: B where {L,N,B<:AbstractBond{L,N}}

    # return a new bond object
    return newBond(
        B,
        deepcopy(from(b)), deepcopy(to(b)),
        deepcopy(label(b)),
        deepcopy(wrap(b))
    )
end
# with new parameters
function similar(
            b       :: B,
            from    :: Integer,
            to      :: Integer,
            label   :: L,
            wrap    :: NTuple{N,<:Integer}
        ) :: B where {L,N,B<:AbstractBond{L,N}}

    # create a new bond object
    b_new = similar(b)
    # set parameters
    from!(b_new, from)
    to!(b_new, to)
    label!(b_new, label)
    wrap!(b_new, wrap)
    # return the new object
    return b_new
end

# export the similar interface
export similar



# ADDITIONAL FANCY SYNTAX
# does not have to be overwritten as it uses interface from above

# check if the bond is periodic
function isPeriodic(
            b :: AbstractBond{L,N}
        ) :: Bool where {L,N}

    # check all wraps explicitly
    for w in wrap(b)
        if w!=0
            # it is periodic if there is a single non-zero wrap
            return true
        end
    end
    # it is not periodic if there is no non-zero wrap
    return false
end

# export the isPeriodic interface
export isPeriodic







################################################################################
#
#	TESTING THE INTERFACE OF BONDS
#	(should never be overwritten by concrete types)
#
################################################################################

# TESTING THE BOND INTERFACE
function testInterface(
            ::Type{T}
        ) :: Bool where {T<:AbstractBond}

	# get the parameterless constructor
	B = Base.typename(T).wrapper

    # iterate over some standard wraps
    for w in [(1,), (0,0), (0,0,0), (1,2,0,0)]
    # iterate over some standard labels
    for l in ["t", 1, 1.0]
        # create a new bond
        bond = newBond(B{typeof(l), length(w)}, 1, 1, l, w)
        # test the interface getters
		from(bond)
		to(bond)
		label(bond)
		wrap(bond)
        # test the interface setters
		from!(bond, 1)
		to!(bond, 1)
		label!(bond, l)
		wrap!(bond, w)
    end
    end

	# return true to indicate the test passed
	return true
end

# export the test functions
export testInterface

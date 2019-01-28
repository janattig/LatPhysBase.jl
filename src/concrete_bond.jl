################################################################################
#
#	CONCRETE TYPE
#
#   Bond{L,N} <: AbstractBond{L,N}
#   --> L is the label type
#   --> N is the dimension of the Bravais lattice that the bond is located in
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
mutable struct Bond{L,N} <: AbstractBond{L,N}

	# indices that the bond connects
	from	:: Int64
	to		:: Int64

	# label
	label	:: L

	# wrap
	wrap	:: NTuple{N, Int64}

end

# export the concrete type
export Bond




# DOCSTRING
"""
    mutable struct Bond{L,N} <: AbstractBond{L,N}

The concrete bond type describes the default bond implementation. It is parametric in two types,
- `L` the type of the bond label
- `N` an integer number specifying the number of periodic directions, it can wrap around


The concrete type implements all interface functions of its abstract supertype which are listed below:
- `newBond` to create a new bond object
- `from` and `from!` to access the index of the bond origin site
- `to` and `to!` to access the index of the bond destination site
- `label` and `label!` to access the bond label
- `wrap` and `wrap!` to access the bond wrap, i.e. in which copy of the unitcell / lattice is points to

To create a `Bond` object, please use `newBond` as shown in the examples section.

# Examples

```julia-REPL
julia> Bond{Int64,2} <: AbstractBond{L,N} where{L,N}
true

julia> b = newBond(Bond{String,2}, 1, 42, "mybond", (1,0) )
...
```
"""
Bond


################################################################################
#
#	IMPLEMENTATION OF INTERFACE FOR CONCRETE BOND TYPE
#	(functions that had to be overwritten by concrete type)
#
################################################################################

# default constructor interface
# used for creation of new bonds
function newBond(
            ::Type{Bond{L,N}},
            from    :: Int64,
            to      :: Int64,
            label   :: L,
            wrap    :: NTuple{N,Int64}
        ) :: Bond{L,N} where {L,N}

    # return the constructed Bond
    return Bond{L,N}(from, to, label, wrap)
end



# get from index / UID (Int64)
function from(
            b :: Bond{L,N}
        ) :: Int64 where {L,N}

    # return the index
    return b.from
end
# set from index / UID (Int64)
function from!(
            b :: Bond{L,N},
            i :: Integer
        ) where {L,N}

    # set the index
    b.from = i
end

# get to index / UID (Int64)
function to(
            b :: Bond{L,N}
        ) :: Int64 where {L,N}

    # return the index
    return b.to
end
# set to index / UID (Int64)
function to!(
            b :: Bond{L,N},
            i :: Integer
        ) :: Int64 where {L,N}

    # set the index
    b.to = i
end



# get label
function label(
            b :: Bond{L,N}
        ) :: L where {L,N}

    # return the label
    return b.label
end
# set label
function label!(
            b :: Bond{L,N},
            l :: L
        ) where {L,N}

    # set the label
    b.label = l
end


# get wrap
function wrap(
            b :: Bond{L,N}
        ) :: NTuple{N,Int64} where {L,N}

    # return the wrap
    return b.wrap
end
# set wrap
function wrap!(
            b :: Bond{L,N},
            w :: NTuple{N, <:Integer}
        ) where {L,N}

    # set the wrap
    b.wrap = w
end

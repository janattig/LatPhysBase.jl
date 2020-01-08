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



function saveBonds(
        bs :: Vector{B},
        fn :: AbstractString,
        group :: AbstractString = "bonds"
        ;
        append :: Bool = false
    ) where {LB,N,B<:Bond{LB,N}}

    # determine the mode based on if one wants to append stuff
    if append
        mode = "r+"
    else
        mode = "w"
    end

    # open the file in mode
    h5open(fn, mode) do ucfile
        # create the group in which the bonds are saved
        group_bonds = g_create(ucfile, group)
        # save the parameters
        attrs(group_bonds)["N"] = Int64(N)
        attrs(group_bonds)["L"] = string(LB)
        # save all from / to values (Int64 arrays)
        group_bonds["from"] = Int64[from(b) for b in bs]
        group_bonds["to"]   = Int64[to(b) for b in bs]
        # save all wraps
        if 0 < Int64(N)
            for n in 1:Int64(N)
                group_bonds["wrap_$(n)"] = Int64[wrap(b)[n] for b in bs]
            end
        end
        # save all labels
        if LB <: Number
            group_bonds["label"] = [label(b) for b in bs]
        else
            group_bonds["label"] = String[string(label(b)) for b in bs]
        end
    end

    # return nothing
    return nothing
end

function loadBonds(
        ::Type{BI},
        fn :: AbstractString,
        group :: AbstractString = "bonds"
    ) where {LBI,NI,BI<:Union{Bond{LBI,NI},Bond}}

    # read attribute data
    attr_data = h5readattr(fn, group)
    # determine N and L based on this
    N  = attr_data["N"]
    LB = Meta.eval(Meta.parse(attr_data["L"]))

    # load all remaining data
    bd_from  = h5read(fn, group*"/from")
    bd_to    = h5read(fn, group*"/to")
    bd_label = h5read(fn, group*"/label")

    if N == 0
        bd_wrap = [Tuple([]) for i in 1:length(bd_from)]
    else
        bd_wrap_parts = [
            h5read(fn, group*"/wrap_"*string(j)) for j in 1:N
        ]
        bd_wrap = [Tuple([bd_wrap_parts[j][i] for j in 1:N]) for i in 1:length(bd_from)]
    end

    # create list of bonds
    bs = Bond{LB,N}[
        newBond(Bond{LB,N}, bd_from[i], bd_to[i], LB(bd_label[i]), bd_wrap[i])
        for i in 1:length(bd_from)
    ]

    # return nothing
    return bs
end


# convinience function for standard type
function loadBonds(
        fn :: AbstractString,
        group :: AbstractString = "bonds"
    )

    return loadBonds(Bond, fn, group)
end

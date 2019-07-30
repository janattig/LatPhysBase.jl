################################################################################
#
#	ABSTRACT TYPE
#
#   Site{L,D}
#   --> L is the label type
#   --> D is the dimension of embedding space
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
abstract type AbstractSite{L,D} end

# export the type
export AbstractSite


# DOCSTRING
"""
    abstract type AbstractSite{L,D}

The abstract site type that describes all site implementations. It is parametric in two types,
- `L` the type of the bond label
- `D` an integer number specifying the number of spatial dimensions in which the site is embedded


The abstract type is equipped with interface functions which are listed in the following. These interface functions have to be implemented by concrete subtypes / structs for the concrete type to be usable in all pre-implemented functions.
- `newSite` to create a new site object of a passed concrete site type
- `label` and `label!` to access the site label
- `point` and `point!` to access the site position in real space

The interface functions throw adequate errors when called but not implemented for concrete types.
See specific documentation for the individual functions.


# Examples

```julia-REPL
julia> AbstractSite{Symbol,3} <: AbstractSite{L,D} where{L,D}
true
```

"""
AbstractSite


"""
Number of spatial dimensions the site is embedded in.
"""
Base.ndims(::Type{S}) where {N,S<:AbstractSite{L,D} where L} = D



################################################################################
#
#	INTERFACING / ACCESSING SITES
#	(functions have to be overwritten by concrete types)
#
################################################################################

# default constructor interface
# used for creation of new sites
"""
    function newSite(
            :: Type{S},
            point   :: Vector{<:Real},
            label   :: L
        ) :: S where {L,S<:AbstractSite{L,D} where D}

Interface function for creation of new `AbstractSite` object of a passed type `S` from a passed `point` and `label`.
Returns a new site object of type `S`.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> s = newSite(Site{String,2}, [0,0], "site1")
...
```
"""
function newSite(
            :: Type{S},
            point   :: Vector{<:Real},
            label   :: L
        ) :: S where {L,S<:AbstractSite{L,D} where D}

    # print an error because implementation for concrete type is missing
    error(  "not implemented function 'newSite' for concrete site type " *
            string(S) * " with label type " * string(L) )
end

# export the newSite interface
export newSite





# get label
"""
    function label(
            s :: AbstractSite{L,D}
        ) :: L where {L,D}

Interface function for obtaining the label of a passed `AbstractSite` object `s`.
Returns an object of type `L`.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> s = newSite(Site{String,2}, [0,0], "site1")

julia> label(s)
"site1"
```
"""
function label(
            s :: AbstractSite{L,D}
        ) :: L where {L,D}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'label' for site type " * string(typeof(s)))
end
# set label
"""
    function label!(
            s :: AbstractSite{L,D},
            l :: L
        ) where {L,D}

Interface function for setting the label of a passed `AbstractSite` object `s`
to a passed value `l` of label type `L`. Returns nothing.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> s = newSite(Site{String,2}, [0,0], "site1")

julia> label!(s, "mylabel")

julia> label(s)
"mylabel"
```
"""
function label!(
            s :: AbstractSite{L,D},
            l :: L
        ) where {L,D}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'label!' for site type " * string(typeof(s)))
end

# export the label interface
export label, label!



# get point
"""
    function point(
            s :: AbstractSite{L,D}
        ) ::Vector{Float64} where {L,D}

Interface function for obtaining the position of a passed `AbstractSite` object `s`.
Returns an object of type `Vector{Float64}` with length `D`.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> s = newSite(Site{String,2}, [0,0], "site1")

julia> point(s)
[0.0, 0.0]
```
"""
function point(
            s :: AbstractSite{L,D}
        ) :: Vector{Float64} where {L,D}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'point' for site type " * string(typeof(s)))
end
# set point
"""
    function point!(
            s :: AbstractSite{L,D},
            p :: Vector{<:Real}
        ) where {L,D}

Interface function for setting the position of a passed `AbstractSite` object `s`
to a passed value `p` of label type `Vector{<:Real}`. Returns nothing.

This function has to be overwritten by a concrete type,
otherwise it will throw an error when used in further functions.


# Examples

```julia-REPL
julia> s = newSite(Site{String,2}, [0,0], "site1")

julia> point!(s, [2.0,1.0])

julia> point(s)
[2.0,1.0]
```
"""
function point!(
            s :: AbstractSite{L,D},
            p :: Vector{<:Real}
        ) where {L,D}

    # print an error because implementation for concrete type is missing
    error("not implemented interface function 'point!' for site type " * string(typeof(s)))
end

# export the point interface
export point, point!




# SIMILAR FUNCTION (can be overwritten but does not have to be overwritten)

# without new parameters
function similar(
            s :: S
        ) :: S where {L,D,S<:AbstractSite{L,D}}

    # return a new site object
    return newSite(S, deepcopy(point(s)), deepcopy(label(s)))
end
# with new parameters
function similar(
            s :: S,
            p :: Vector{<:Real},
            l :: L
        ) :: S where {L,D,S<:AbstractSite{L,D}}

    # create a new site object
    s_new = similar(s)
    # set parameters
    point!(s_new, p)
    label!(s_new, l)
    # return the new object
    return s_new
end

# export the similar interface
export similar





################################################################################
#
#	TESTING THE INTERFACE OF SITES
#	(should never be overwritten by concrete types)
#
################################################################################

# TESTING THE SITE INTERFACE
function testInterface(
            ::Type{T}
        ) :: Bool where {T<:AbstractSite}

	# get the parameterless constructor
	S = Base.typename(T).wrapper

    # iterate over some standard points
    for p in Vector{Float64}[[1.0,], [1.0, 1.0], [0.0, 0.0, 0.0, 0.0]]
    # iterate over some standard labels
    for l in ["t", 1, 1.0]
        # create a new site
        s = newSite(S{typeof(l), length(p)}, p,l)
        # test the interface by getting label and point
		label(s)
		point(s)
        # set both label and point
        label!(s, l)
        point!(s, p)
    end
    end

	# return true to indicate the test passed
	return true
end

# export the test functions
export testInterface

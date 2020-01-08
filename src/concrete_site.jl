################################################################################
#
#	CONCRETE TYPE
#
#   Site{L,D} <: AbstractSite{L,D}
#   --> L is the label type
#   --> D is the dimension of embedding space
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
mutable struct Site{L,D} <: AbstractSite{L,D}

	# point
	point	:: Vector{Float64}

	# label
	label	:: L

end

# export the concrete type
export Site





################################################################################
#
#	IMPLEMENTATION OF INTERFACE FOR CONCRETE SITE TYPE
#	(functions that had to be overwritten by concrete type)
#
################################################################################

# default constructor interface
# used for creation of new sites
function newSite(
            :: Type{Site{L,D}},
            point   :: Vector{<:Real},
            label   :: L
        ) :: Site{L,D} where {L,D}

    # check if correct dimension is given
    @assert length(point) == D

    # return a new object
    return Site{L,D}(point, label)
end





# get label
function label(
            s :: Site{L,D}
        ) :: L where {L,D}

    # return the label
    return s.label
end
# set label
function label!(
            s :: Site{L,D},
            l :: L
        ) where {L,D}

    # return the label
    s.label = l
end


# get point
function point(
            s :: Site{L,D}
        ) :: Vector{Float64} where {L,D}

    # return the point
    return s.point
end
# set point
function point!(
            s :: Site{L,D},
            p :: Vector{<:Real}
        ) where {L,D}

    # return the point
    s.point = p
end



function saveSites(
        ss :: Vector{S},
        fn :: AbstractString,
        group :: AbstractString = "sites"
        ;
        append :: Bool = false
    ) where {LS,D,S<:Site{LS,D}}

    # determine the mode based on if one wants to append stuff
    if append
        mode = "r+"
    else
        mode = "w"
    end

    # open the file in mode
    h5open(fn, mode) do ucfile
        # create the group in which the bonds are saved
        group_sites = g_create(ucfile, group)
        # save the parameters
        attrs(group_sites)["D"] = Int64(D)
        attrs(group_sites)["L"] = string(LS)
        # save all Positions (D dimensions)
        if 0 < Int64(D)
            for n in 1:Int64(D)
                group_sites["point_$(n)"] = Float64[point(s)[n] for s in ss]
            end
        end
        # save all labels
        if LS <: Number
            group_sites["label"] = [label(s) for s in ss]
        else
            group_sites["label"] = String[string(label(s)) for s in ss]
        end
    end

    # return nothing
    return nothing
end

function loadSites(
        ::Type{SI},
        fn :: AbstractString,
        group :: AbstractString = "sites"
    ) where {LSI,DI,SI<:Union{Site{LSI,DI},Site}}

    # read attribute data
    attr_data = h5readattr(fn, group)
    # determine D and L based on this
    D  = attr_data["D"]
    LS = Meta.eval(Meta.parse(attr_data["L"]))

    # load all remaining data
    st_label = h5read(fn, group*"/label")

    if D == 0
        st_point = [Float64[] for i in 1:length(st_label)]
    else
        st_point_parts = [
            h5read(fn, group*"/point_"*string(j)) for j in 1:D
        ]
        st_point = Vector{Float64}[Float64[st_point_parts[j][i] for j in 1:D] for i in 1:length(st_label)]
    end

    # create list of sites
    ss = Site{LS,D}[
        newSite(Site{LS,D}, st_point[i], LS(st_label[i]))
        for i in 1:length(st_label)
    ]

    # return nothing
    return ss
end


# convinience function for standard type
function loadSites(
        fn :: AbstractString,
        group :: AbstractString = "sites"
    )

    return loadSites(Site, fn, group)
end

# CUSTOM NICE PRINTING FOR VARIOUS TYPES



# ABSTRACT TYPES



# single SITE

# all labels
function show(io::IO, s::S) where {L,D,S<:AbstractSite{L,D}}
    print(io, S, " @", point(s), ": ", label(s))
end
# string labels
function show(io::IO, s::S) where {L<:AbstractString,D,S<:AbstractSite{L,D}}
    print(io, S, " @", point(s), ": \"", label(s),"\"")
end
# symbol labels
function show(io::IO, s::S) where {L<:Symbol,D,S<:AbstractSite{L,D}}
    print(io, S, " @", point(s), ": :", label(s))
end



# single BOND

# all labels
function show(io::IO, b::B) where {L,N,B<:AbstractBond{L,N}}
    print(io, B, " ", from(b), "-->", to(b), " @", wrap(b), ": ", label(b))
end
# string labels
function show(io::IO, b::B) where {L<:AbstractString,N,B<:AbstractBond{L,N}}
    print(io, B, " ", from(b), "-->", to(b), " @", wrap(b), ": \"", label(b),"\"")
end
# symbol labels
function show(io::IO, b::B) where {L<:Symbol,N,B<:AbstractBond{L,N}}
    print(io, B, " ", from(b), "-->", to(b), " @", wrap(b), ": :", label(b))
end



# single UNITCELL
function show(io::IO, u::U) where {D,N,LS,LB,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U<:AbstractUnitcell{S,B}}
    print(io, "Unitcell object\n--> type ", U, "\n--> ", length(sites(u)), " sites of type ", S, "\n--> ", length(bonds(u)), " bonds of type ", B)
end

# single LATTICE
function show(io::IO, la::L) where {D,N,LS,LB,U,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},L<:AbstractLattice{S,B,U}}
    print(io, "Lattice object\n--> type ", L, "\n--> ", length(sites(la)), " sites of type ", S, "\n--> ", length(bonds(la)), " bonds of type ", B, "\n--> unitcell of type ", U)
end

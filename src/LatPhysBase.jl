################################################################################
#
#   module LatPhysBase
#
#   --> ABSTRACT TYPE DEFINITION
#           - AbstractSite{L,D}
#           - AbstractBond{L,N}
#           - AbstractUnitcell{S,B}
#           - AbstractLattice{S,B,U}
#
#   --> INTERFACING ABSTRACT TYPES
#           - AbstractSite{L,D}
#               - positions
#               - label
#           - AbstractBond{L,N}
#               - connecting identifiers
#               - label
#               - wrap
#           - AbstractUnitcell{S,B}
#               - Bravais lattice vectors
#               - sites
#               - bonds
#           - AbstractLattice{S,B,U}
#               - Unitcell
#               - Bravais lattice vectors
#               - sites
#               - bonds
#
#   --> NAIVE STRUCT DEFINITIONS
#           - Site{L,D}
#           - Bond{L,N}
#           - Unitcell{S,B}
#           - Lattice{S,B,U}
#
#   --> IMPLEMENTING JULIA.BASE FUNCTIONS
#           - show
#           - print
#
################################################################################

# module start
module LatPhysBase



# import functions from Base to be overwritten
import Base.show
import Base.similar





# ABSTRACT TYPES INCLUDING INTERFACE DEFINITION

# Sites
include("abstract_site.jl")
# Bonds
include("abstract_bond.jl")
# Unitcells
include("abstract_unitcell.jl")
# Lattices
include("abstract_lattice.jl")



# CONCRETE TYPES INCLUDING INTERFACE IMPLEMENTATION

# Sites
include("concrete_site.jl")
# Bonds
include("concrete_bond.jl")
# Unitcells
include("concrete_unitcell.jl")
# Lattices
include("concrete_lattice.jl")


# HAMILTONIANS

# Abstract type definition
include("abstract_hamiltonian.jl")

# Concrete Hamiltonian: Heisenberg
include("concrete_hamiltonian_heisenberg.jl")
# Concrete Hamiltonian: Kitaev
include("concrete_hamiltonian_kitaev.jl")



# DEFAULT LABELS
include("default_labels.jl")


# CUSTOM NICE PRINTING
include("show.jl")


# module end
end

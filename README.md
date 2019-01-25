# LatPhysBase.jl

Base module of [`LatticePhysics.jl`](https://github.com/janattig/LatticePhysics.jl).



## Contents

Provides the abstract and concrete Base types of [`LatticePhysics.jl`](https://github.com/janattig/LatticePhysics.jl) as well as their interface definitions. These include the following:
1.  `AbstractBond{L,N}` and `Bond{L,N}`
2.  `AbstractSite{L,D}` and `Site{L,D}`
3.  `AbstractUnitcell{S,B}` and `Unitcell{S,B}`
4.  `AbstractLattice{S,B,U}` and `Lattice{S,B,U}`


## Installation

For usage purposes only, you can install the package via the package mode in Julia (Pkg). However, since the package
is not listed in the Julia package repositories, you have to use
```julia
(v1.0) pkg> add "https://github.com/janattig/LatPhysBase.jl"
```

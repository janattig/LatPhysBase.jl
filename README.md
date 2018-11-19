# LatPhysBase.jl

Base module of [`LatticePhysics.jl`](http://gitsrv.thp.uni-koeln.de/attig/LatticePhysics.jl). which contains lattice based calculations and plotting for Julia v.1.0.* .



## Contents

Provides the abstract and concrete Base types of [`LatticePhysics.jl`](http://gitsrv.thp.uni-koeln.de/attig/LatticePhysics.jl) as well as their interface definitions. These include the following:
1.  `AbstractBond{L,N}` and `Bond{L,N}`
2.  `AbstractSite{L,D}` and `Site{L,D}`
3.  `AbstractUnitcell{S,B}` and `Unitcell{S,B}`
4.  `AbstractLattice{S,B,U}` and `Lattice{S,B,U}`


## Installation (usage only):

For usage purposes only, you can install the package via the package mode in Julia (Pkg). However, since the package
is not listed in the Julia package repositories, you have to use
```julia
pkg(1.0)> add "git@gitsrv.thp.uni-koeln.de:attig/LatPhysBase.jl.git"
```
Note: this can lead to Errors under Windows 10 due to incorrect SSH access. Use the following command instead:
```julia
pkg(1.0)> add "http://gitsrv.thp.uni-koeln.de/attig/LatPhysBase.jl.git"
```
You will be prompted a username and password validation but it should work the same way.


## Installation (developement):

For developement purposes, it is best to clone the package via git to a developement
git location of your choice and use
```julia
pkg(1.0)> dev "path/to/the/repository/on/your/machine"
```

Alternatively, you could use
```julia
pkg(1.0)> dev "git@gitsrv.thp.uni-koeln.de:attig/LatPhysBase.jl.git"
```
or (on Windows)
```julia
pkg(1.0)> dev "http://gitsrv.thp.uni-koeln.de/attig/LatPhysBase.jl.git"
```
to clone a development version of the package to `~/.julia/dev/`.


Finally, develope the package as you are used to within the editor of your choice.

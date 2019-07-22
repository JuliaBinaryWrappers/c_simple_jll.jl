module c_simple_jll
using Pkg.BinaryPlatforms, Libdl

platforms = Platform[
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(libgfortran_version=v"5.0.0", libstdcxx_version=v"3.4.26", cxxstring_abi=:cxx11)),
]

# From the available options, choose the best platform
best_platform = select_platform(Dict(p => triplet(p) for p in platforms))

# Load the appropriate wrappers
include(joinpath(@__DIR__, "wrappers", "$(best_platform).jl"))

end  # module c_simple_jll

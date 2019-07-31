module c_simple_jll
using Pkg.BinaryPlatforms, Pkg.Artifacts, Libdl

platforms = Platform[
    Linux(:i686, libc=:glibc),
    Linux(:powerpc64le, libc=:glibc),
    Linux(:i686, libc=:musl),
    Windows(:i686),
    Linux(:aarch64, libc=:musl),
    MacOS(:x86_64),
    Windows(:x86_64),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf),
    Linux(:x86_64, libc=:glibc),
    FreeBSD(:x86_64),
    Linux(:aarch64, libc=:glibc),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf),
    Linux(:x86_64, libc=:musl),
]

# From the available options, choose the best platform
best_platform = select_platform(Dict(p => triplet(p) for p in platforms))

# Load the appropriate wrappers
include(joinpath(@__DIR__, "wrappers", "$(best_platform).jl"))

end  # module c_simple_jll

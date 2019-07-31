# Autogenerated wrapper script for c_simple_jll for powerpc64le-linux-gnu
export c_simple, libc_simple

## Global variables
const PATH_list = String[]
const LIBPATH_list = String[]
PATH = ""
LIBPATH = ""
LIBPATH_env = "LD_LIBRARY_PATH"

# Relative path to `c_simple`
const c_simple_splitpath = ["bin", "c_simple"]

# This will be filled out by __init__() for all products, as it must be done at runtime
c_simple_path = ""

# c_simple-specific global declaration
function c_simple(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(ENV["PATH"], ':', PATH)
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        if !isempty(get(ENV, LIBPATH_env, ""))
            env_mapping[LIBPATH_env] = string(ENV[LIBPATH_env], ':', LIBPATH)
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(c_simple_path)
    end
end


# Relative path to `libc_simple`
const libc_simple_splitpath = ["lib", "libc_simple.so"]

# This will be filled out by __init__() for all products, as it must be done at runtime
libc_simple_path = ""

# libc_simple-specific global declaration
# This will be filled out by __init__()
libc_simple_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const libc_simple = "libc_simple.so"


"""
Open all libraries
"""
function __init__()
    global prefix = abspath(joinpath(@__DIR__, ".."))

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list

    global c_simple_path = abspath(joinpath(artifact"c_simple", c_simple_splitpath...))

    push!(PATH_list, dirname(c_simple_path))
    global libc_simple_path = abspath(joinpath(artifact"c_simple", libc_simple_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global libc_simple_handle = dlopen(libc_simple_path)
    push!(LIBPATH_list, dirname(libc_simple_path))

    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ':')
    global LIBPATH = join(LIBPATH_list, ':')

    # Add each element of LIBPATH to our DL_LOAD_PATH (necessary on platforms
    # that don't honor our "already opened" trick)
    #for lp in LIBPATH_list
    #    push!(DL_LOAD_PATH, lp)
    #end
end  # __init__()


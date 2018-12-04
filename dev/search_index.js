var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.jl Documentation",
    "category": "page",
    "text": ""
},

{
    "location": "#Inpaintings.jl-Documentation-1",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.jl Documentation",
    "category": "section",
    "text": "Inpaintings.jl provides functions that perform a similar task to MATLAB\'s inpaint_nans function.  (MATLAB\'s inpaint_nans was originally written by John d\'Errico and is available on the MathWorks File Exchange website.)inpaint_nans takes a vector or a matrix as input and fills (\"inpaints\") the NaNs by solving a simple 1D or 2D PDE.So far Inpaintings.jl only replicates John d\'Errico\'s method 0 well, which is well suited for filling NaNs in a \"diffusive\" way. Methods 1 and 3 are on their way. Other methods will come next."
},

{
    "location": "#Usage-1",
    "page": "Inpaintings.jl Documentation",
    "title": "Usage",
    "category": "section",
    "text": "Use the package as you would any Julia packageDocTestSetup = quote\n    using Inpaintings\nendThe command inpaint_nans(A) will fill the NaNs of an Array A (that has some NaNs):# Making a test matrix A with some NaNs by replacing values from fullA\nn = 10\nfullA = float(collect(1:n) * collect(1:n)\')\nA = copy(fullA)\nA[1:5, 1:5] .= NaN # replace some values with some NaNs\nB = inpaint(A, NaN)\nB ≈ fullA\n\n# output\n\ntrue"
},

{
    "location": "#Inpaintings.inpaint-Tuple{Any,Any}",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.inpaint",
    "category": "method",
    "text": "inpaint(f, A; method=1, cycledims=Int64[])\n\nInpaints values in A that f gives true on by solving a PDE. Inspired by MATLAB\'s inpaint_nans\'s (by John d\'Errico). See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans.\n\n\n\n\n\n"
},

{
    "location": "#Inpaintings.inpaint-Union{Tuple{Union{Array{Union{Missing, T},1}, Array{Union{Missing, T},2}}}, Tuple{T}} where T<:AbstractFloat",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.inpaint",
    "category": "method",
    "text": "inpaint(A::VecOrMat{AbstractFloat})\n\n\n\n\n\n"
},

{
    "location": "#Inpaintings.inpaint_method0-Tuple{Any,Array{T,1} where T}",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.inpaint_method0",
    "category": "method",
    "text": "inpaint_method0(f, A::Vector)\n\nInpaints values in A that f gives true on by solving a simple diffusion PDE. The partial differential equation (PDE) is defined by the standard Laplacian, Δ = ∇^2. Inspired by MATLAB\'s inpaint_nans\'s method 0 for vectors (by John d\'Errico). See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans.\n\n\n\n\n\n"
},

{
    "location": "#Inpaintings.inpaint_method1-Tuple{Any,Array}",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.inpaint_method1",
    "category": "method",
    "text": "inpaint_method1(f, A::Array, cycledims=Int64[])\n\nInpaints values in A that f gives true on by solving a simple diffusion PDE. Default method for inpaint. The partial differential equation (PDE) is defined by the standard Laplacian, Δ = ∇^2. Inspired by MATLAB\'s inpaint_nans\'s method 0 for matrices (by John d\'Errico). See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans. The discrete stencil used for Δ looks like\n\n      ┌───┐\n      │ 1 │\n      └─┬─┘\n        │\n┌───┐ ┌─┴─┐ ┌───┐\n│ 1 ├─┤-4 ├─┤ 1 │\n└───┘ └─┬─┘ └───┘\n        │\n      ┌─┴─┐\n      │ 1 │\n      └───┘\n\nBy default, the stencil is not applied at the borders. Instead, its 1D component,\n\n┌───┐ ┌───┐ ┌───┐\n│ 1 ├─┤-2 ├─┤ 1 │\n└───┘ └───┘ └───┘\n\nis applied where it fits at the borders. However, the user can supply a list of dimensions that should be considered cyclic. In this case, the sentil will be used also at the borders and \"jump\" to the other side. This is particularly useful for, e.g., world maps with longitudes spanning the entire globe.\n\n\n\n\n\n"
},

{
    "location": "#Inpaintings.list_neighbors-Tuple{Any,Any,Any}",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.list_neighbors",
    "category": "method",
    "text": "list_neighbors(A, idx, neighbors)\n\nLists all the neighbors of the indices in idx in Array A. Neighbors already in idx are accepted. The argument neighnors contains a list of the neighbors about the origin coordinate (0, 0, ...). In other words, it is a Vector of CartesianIndex such that the direct neighbors of index i are given by i + n for n in neighbors. Inspired by MATLAB\'s inpaint_nans\'s identify_neighbors (by John d\'Errico). See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans.\n\n\n\n\n\n"
},

{
    "location": "#Functions-1",
    "page": "Inpaintings.jl Documentation",
    "title": "Functions",
    "category": "section",
    "text": "Modules = [Inpaintings]\nOrder   = [:function, :type]"
},

]}

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
    "text": "Use the package as you would any Julia packageDocTestSetup = quote\n    using Inpaintings\nendThe command inpaint_nans(A) will fill the NaNs of an Array A (that has some NaNs):# Making a test matrix A with some NaNs by replacing values from fullA\nn = 10\nfullA = float(collect(1:n) * collect(1:n)\')\nA = copy(fullA)\nA[1:5, 1:5] .= NaN # replace some values with some NaNs\nB = inpaint_nans(A)\nB ≈ fullA\n\n# output\n\ntrue"
},

{
    "location": "#Inpaintings.inpaint_nans",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.inpaint_nans",
    "category": "function",
    "text": "inpaint_nans(A, method=0)\n\nInpaints NaN values by solving a diffusion PDE for the standard Laplacian. Inspired by MATLAB\'s inpaint_nans\'s (by John d\'Errico). See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans. Currently only method 0 is implemented.\n\n\n\n\n\n"
},

{
    "location": "#Inpaintings.inpaint_nans_method0-Tuple{Array{T,1} where T}",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.inpaint_nans_method0",
    "category": "method",
    "text": "inpaint_nans_method0(A::Vector)\n\nInpaints NaN values by solving a diffusion PDE for the standard Laplacian. Inspired by MATLAB\'s inpaint_nans\'s method 0 for vectors (by John d\'Errico). See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans.\n\n\n\n\n\n"
},

{
    "location": "#Inpaintings.inpaint_nans_method0-Union{Tuple{Array{T,2}}, Tuple{T}} where T",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.inpaint_nans_method0",
    "category": "method",
    "text": "inpaint_nans_method0(A::Array{T,2}) where T\n\nInpaints NaN values by solving a diffusion PDE for the standard Laplacian. Inspired by MATLAB\'s inpaint_nans\'s method 0 for matrices (by John d\'Errico). See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans. The discrete stencil used for ∇² looks like\n\n            ┌───┐\n            │ 1 │\n            └─┬─┘\n              │\n      ┌───┐ ┌─┴─┐ ┌───┐\n      │ 1 ├─┤-4 ├─┤ 1 │\n      └───┘ └─┬─┘ └───┘\n              │\n            ┌─┴─┐\n            │ 1 │\n            └───┘\n\nThe stencil is not applied at the coreners, but its 1D components,\n\n   ┌───┐\n   │ 1 │\n   └─┬─┘\n     │\n   ┌─┴─┐        ┌───┐ ┌───┐ ┌───┐\n   │-2 │   or   │ 1 ├─┤-2 ├─┤ 1 │\n   └─┬─┘        └───┘ └───┘ └───┘\n     │\n   ┌─┴─┐\n   │ 1 │\n   └───┘\n\nare applied at borders.\n\n\n\n\n\n"
},

{
    "location": "#Inpaintings.inpaint_nans_method1-Union{Tuple{Array{T,2}}, Tuple{T}, Tuple{Array{T,2},Any}} where T",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.inpaint_nans_method1",
    "category": "method",
    "text": "inpaint_nans_method1(A::Array{T,2}) where T\n\nInpaints NaN values by solving a diffusion PDE for the standard Laplacian. Inspired by MATLAB\'s inpaint_nans\'s method 0 for matrices (by John d\'Errico). See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans. The discrete stencil used for ∇² looks like\n\n            ┌───┐\n            │ 1 │\n            └─┬─┘\n              │\n      ┌───┐ ┌─┴─┐ ┌───┐\n      │ 1 ├─┤-4 ├─┤ 1 │\n      └───┘ └─┬─┘ └───┘\n              │\n            ┌─┴─┐\n            │ 1 │\n            └───┘\n\nThe stencil is not applied at the coreners, but its 1D components,\n\n   ┌───┐\n   │ 1 │\n   └─┬─┘\n     │\n   ┌─┴─┐        ┌───┐ ┌───┐ ┌───┐\n   │-2 │   or   │ 1 ├─┤-2 ├─┤ 1 │\n   └─┬─┘        └───┘ └───┘ └───┘\n     │\n   ┌─┴─┐\n   │ 1 │\n   └───┘\n\nare applied at borders.\n\n\n\n\n\n"
},

{
    "location": "#Inpaintings.inpaint_nans_method3-Union{Tuple{Array{T,2}}, Tuple{T}} where T",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.inpaint_nans_method3",
    "category": "method",
    "text": "inpaint_nans_method3(A::Array{T,2}) where T\n\nInpaints NaN values by solving a diffusion PDE for ∇⁴: Inspired by MATLAB\'s inpaint_nans\'s method 3 for matrices (by John d\'Errico). The discrete stencil used for ∇⁴ looks like\n\n            ┌───┐\n            │ 1 │\n            └─┬─┘\n              │\n      ┌───┐ ┌─┴─┐ ┌───┐\n      │ 2 ├─┤-8 ├─┤ 2 │\n      └─┬─┘ └─┬─┘ └─┬─┘\n        │     │     │\n┌───┐ ┌─┴─┐ ┌─┴─┐ ┌─┴─┐ ┌───┐\n│ 1 ├─┤-8 ├─┤20 ├─┤-8 ├─┤ 1 │\n└───┘ └─┬─┘ └─┬─┘ └─┬─┘ └───┘\n        │     │     │\n      ┌─┴─┐ ┌─┴─┐ ┌─┴─┐\n      │ 2 ├─┤-8 ├─┤ 2 │\n      └───┘ └─┬─┘ └───┘\n              │\n            ┌─┴─┐\n            │ 1 │\n            └───┘\n\nThe stencil is actually constructed from its 1st order 1D components,\n\n   ┌───┐\n   │ 1 │\n   └─┬─┘\n     │\n   ┌─┴─┐        ┌───┐ ┌───┐ ┌───┐\n   │-2 │   or   │ 1 ├─┤-2 ├─┤ 1 │\n   └─┬─┘        └───┘ └───┘ └───┘\n     │\n   ┌─┴─┐\n   │ 1 │\n   └───┘\n\nwhich are applied at the borders.\n\n\n\n\n\n"
},

{
    "location": "#Inpaintings.inpaint_nans_method6-Union{Tuple{Array{T,2}}, Tuple{T}} where T",
    "page": "Inpaintings.jl Documentation",
    "title": "Inpaintings.inpaint_nans_method6",
    "category": "method",
    "text": "inpaint_nans_method6(A::Array{T,2}) where T\n\nInpaints NaN values by solving a diffusion PDE for a diagonally filled Laplacian:\n\nmathbfD_xy^2 = beginbmatrix0250502505-30502505025endbmatrix\n\nInspired by MATLAB\'s inpaint_nans\'s method 0 for matrices (by John d\'Errico). See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans.\n\n\n\n\n\n"
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

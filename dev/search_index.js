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
    "text": "This package provides MATLAB\'s inpaint_nans function originally written by John d\'Errico (and available on the MathWorks File Exchange website).inpaint_nans takes a vector or a matrix as input and fills the NaNs by solving a simple 1d or 2d PDE with a finite difference approximation of a Laplacian operator.So far Inpaintings.jl only replicates John d\'Errico\'s method 0 well, which is well suited for filling NaNs in a \"diffusive\" way. Methods 1 and 3 are on their way."
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
    "location": "#Functions-1",
    "page": "Inpaintings.jl Documentation",
    "title": "Functions",
    "category": "section",
    "text": "inpaint_nans"
},

]}

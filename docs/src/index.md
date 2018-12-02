# Inpaintings.jl Documentation

[Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) provides functions that perform a similar task to MATLAB's `inpaint_nans` function. 
(MATLAB's `inpaint_nans` was originally written by John d'Errico and is available on the MathWorks [File Exchange website](https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans).)

`inpaint_nans` takes a vector or a matrix as input and fills ("inpaints") the `NaN`s by solving a simple 1D or 2D PDE.

So far [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) only replicates John d'Errico's method `0` well, which is well suited for filling `NaN`s in a "diffusive" way.
Methods `1` and `3` are on their way.
Other methods will come next.

## Usage

Use the package as you would any Julia package

```@meta
DocTestSetup = quote
    using Inpaintings
end
```

The command `inpaint_nans(A)` will fill the `NaN`s of an Array `A` (that has some `NaN`s):
```jldoctest usage
# Making a test matrix A with some NaNs by replacing values from fullA
n = 10
fullA = float(collect(1:n) * collect(1:n)')
A = copy(fullA)
A[1:5, 1:5] .= NaN # replace some values with some NaNs
B = inpaint_nans(A)
B ≈ fullA

# output

true
```

## Functions

```@docs
inpaint_nans
```


# Inpaintings.jl

<p>
  <a href="https://github.com/briochemc/Inpaintings.jl/actions">
    <img src="https://img.shields.io/github/actions/workflow/status/briochemc/Inpaintings.jl/mac.yml?label=OSX&logo=Apple&logoColor=white&style=flat-square">
  </a>
  <a href="https://github.com/briochemc/Inpaintings.jl/actions">
    <img src="https://img.shields.io/github/actions/workflow/status/briochemc/Inpaintings.jl/linux.yml?label=Linux&logo=Linux&logoColor=white&style=flat-square">
  </a>
  <a href="https://github.com/briochemc/Inpaintings.jl/actions">
    <img src="https://img.shields.io/github/actions/workflow/status/briochemc/Inpaintings.jl/windows.yml?label=Windows&logo=Windows&logoColor=white&style=flat-square">
  </a>
  <a href="https://codecov.io/gh/briochemc/Inpaintings.jl">
    <img src="https://img.shields.io/codecov/c/github/briochemc/Inpaintings.jl/master?label=Codecov&logo=codecov&logoColor=white&style=flat-square">
  </a>
  <a href="https://github.com/briochemc/Inpaintings.jl/blob/master/LICENSE">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg">
  </a>
</p>

## Description

This package provides a Julia version of MATLAB's `inpaint_nans` function (originally written by John d'Errico, available on the MathWorks [File Exchange website](https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans) and ported here with his authorization by personal communication).

> [!WARNING]  
> Out of the methods available in MATLAB's `inpaint_nans`, [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) currently only implements MATLAB's method `1`.

Simply put, [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) provides a simple `inpaint` function, which takes an array `A` as input and inpaints its `missing` values by solving a simple *n*-dimensional PDE.
The `inpaint` function can also be used to inpaint `NaN`s or any other values, thanks to the syntax described below and in the [documentation](https://briochemc.github.io/Inpaintings.jl/stable).

## Usage

> [!TIP]  
> Like every Julia package you must first add it via `]add Inpaintings`.
> And every time you want to use [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl), you must start with
> ```julia
> julia> using Inpaintings
> ```

### Inpaint missing values

```julia
julia> inpaint(A) # will inpaint missing values
```
The array to be inpainted can be a vector, a matrix, or even an *n*-dimensional array.

### Inpaint `NaN`s

If your array `A` has no `missing`s, then
```julia
julia> inpaint(A) # will inpaint NaN values
```

### Inpaint specified value

To inpaint any specified value, use
```julia
julia> inpaint(A, -999) # will inpaint -999 values
```
> [!TIP]  
> The value to inpaint can be specified as `NaN` or `missing`, too, if you want to have explicit code.

### Inpaint with a condition function

Use a function `f` as a first argument (`f` will be applied to all the elements of the array and must return a boolean), to inpaint those values:
```julia
julia> inpaint(f, A)
```
In this case, the values of `A` for which `f` returns `true` will be inpainted.
> [!TIP]  
> `f` can be `ismissing` or `isnan`, but it can also be something like `x -> x < 0` for example.

### Cyclic dimensions

To allow cyclic dimensions, use
```julia
julia> inpaint(A, cycledims=[1]) # will inpaint A with dimension 1 as cyclic
```
(The cyclic dimensions must be an array of `Int64` that contains the dimension number of cyclic dimensions.)

### Documentation

See the [docs](https://briochemc.github.io/Inpaintings.jl/stable) if you want to see more examples.

### Contributions

Suggestions, ideas, issues, and PRs to improve the code or implement additional methods are welcome!

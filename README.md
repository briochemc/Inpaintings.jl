# Inpaintings.jl

<p>
  <a href="https://briochemc.github.io/Inpaintings.jl/dev">
    <img src=https://img.shields.io/badge/docs-dev-blue.svg>
  </a>
  <a href="https://briochemc.github.io/Inpaintings.jl/stable">
    <img src=https://img.shields.io/badge/docs-stable-blue.svg>
  </a>
  <a href="https://ci.appveyor.com/project/briochemc/Inpaintings-jl">
    <img src=https://ci.appveyor.com/api/projects/status/udbwakr621jbyvj1?svg=true>
  </a>
  <a href="https://travis-ci.com/briochemc/Inpaintings.jl">
    <img alt="Build Status" src="https://travis-ci.com/briochemc/Inpaintings.jl.svg?branch=master">
  </a>
  <a href='https://coveralls.io/github/briochemc/Inpaintings.jl?branch=master'>
    <img src='https://coveralls.io/repos/github/briochemc/Inpaintings.jl/badge.svg?branch=master' alt='Coverage Status' />
  </a>
  <a href="https://codecov.io/gh/briochemc/Inpaintings.jl">
    <img src="https://codecov.io/gh/briochemc/Inpaintings.jl/branch/master/graph/badge.svg" />
  </a>
  <a href="https://github.com/briochemc/Inpaintings.jl/blob/master/LICENSE">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg">
  </a>
</p>

## Description

This package provides a Julia version of MATLAB's `inpaint_nans` function (originally written by John d'Errico, available on the MathWorks [File Exchange website](https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans) and ported here with his authorization by personal communication).

Simply put, [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) provides a simple `inpaint` function, which takes an array `A` as input and inpaints its `missing` values by solving a simple *n*-dimensional PDE.
The `inpaint` function can also be used to inpaint `NaN`s or any other values, thanks to the syntax described below and in the [documentation](https://briochemc.github.io/Inpaintings.jl/stable).

## Usage: 

Like every Julia package you must first add it via `]add Inpaintings`.
And every time you want to use [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl), you must start with
```julia
julia> using Inpaintings
```

In order to `inpaint` an array `A`'s `missing` values, simply apply `inpaint` to your array:
```julia
julia> inpaint(A) # will inpaint missing values
```
The array to be inpainted can be a vector, a matrix, or even an *n*-dimensional array. 

If your array `A` has some `NaN` values and is filled with floats otherwise, then
```julia
julia> inpaint(A) # will inpaint NaN values
```

[Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) provides a syntax to inpaint any specified value via
```julia
julia> inpaint(A, -999) # will inpaint -999 values
```
(The value to inpaint can be specified as `NaN` or `missing`, too!)

Alternatively, [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) also provides a syntax taking a boolean function `f` as an argument before the array (`f` will be applied to all the elements of the array and must return a boolean).
```julia
julia> inpaint(f, A)
```
In this case, the values of `A` for which `f` returns `true` will be inpainted.
(For example, `f` can be, e.g., `ismissing` or `isnan`, but it can also be `x -> x < 0`.)

Finally, [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) provides a syntax to allow some dimensions to be assumed cyclic: 
```julia
julia> inpaint(A, cycledims=[1]) # will inpaint A with dimension 1 as cyclic
```
(The cyclic dimensions must be an array of `Int64` that contains the dimension number of cyclic dimensions.)

See the [docs](https://briochemc.github.io/Inpaintings.jl/stable) if you want to see more examples.

## Comparison to MATLAB version

Out of the methods available in MATLAB's `inpaint_nans`, [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) currently only implements the following methods:
- [ ] method `0`
- [x] method `1`
- [ ] method `2`
- [ ] method `3`
- [ ] method `4`
- [ ] method `5`

In the future, it is likely that only `inpaint_nans`'s method `4` (the spring analogy) will be additionally implemented.

## TODOs

Suggestions, ideas, issues, and PRs welcome!

- [ ] improve efficiency
- [ ] Julian-ify the code
- [ ] Add notebook exampls via Literate.jl

# Inpaintings.jl

<p>
  <a href="https://briochemc.github.io/Inpaintings.jl/stable">
    <img src=https://img.shields.io/badge/docs-stable-blue.svg>
  </a>
  <a href="https://ci.appveyor.com/project/briochemc/Inpaintings-jl">
    <img src=https://ci.appveyor.com/api/projects/status/udbwakr621jbyvj1?svg=true>
  </a>
  <a href="https://travis-ci.com/briochemc/Inpaintings.jl">
    <img alt="Build Status" src="https://travis-ci.com/briochemc/Inpaintings.jl.svg?branch=master">
  </a>
  <a href="https://travis-ci.org/briochemc/Inpaintings.jl">
    <img alt="Build Status" src="https://travis-ci.org/briochemc/Inpaintings.jl.svg?branch=master">
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

Simply put, `inpaint_nans` takes a vector or a matrix `A` as input and fills its `NaN` values by solving a simple (1D or 2D) PDE.

## Usage: 

Simply apply `inpaint_nans` to your array:
```julia
julia> inpaint_nans(A)
```
Or specify the method:
```julia
julia> inpaint_nans(A, method)
```
where `method` must be either `0`, `1`, or `3` (for now).

With method `1`, you can specify if some dimensions are cyclic via, e.g., 
```julia
julia> inpaint_nans(A, 1, [1])
```
or
```julia
julia> inpaint_nans(A, 1, [1, 2])
```

## Comparison to MATLAB version

Out of the methods available in MATLAB's `inpaint_nans`, [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) currently only implements the following methods:
- [x] method `0`
- [x] method `1`
- [ ] method `2`
- [x] method `3` (beware: not an exact match)
- [ ] method `4`
- [ ] method `5`

There is currently only one test: for method `0` (which gives the same result as method `1`). 
This test checks that inpainting the `NaN` values of a sample matrix defined by MATLAB's [`peaks`](https://www.mathworks.com/help/matlab/ref/peaks.html) function does so with the same values as MATLAB's version of `inpaint_nans`.

## TODOs

Suggestions, ideas, issues, and PRs welcome!

- [ ] Add functionality to replace not only `NaN`s but also `nothing`s and `missing`s
- [ ] improve efficiency
- [ ] Julian-ify the code
- [ ] improve documentation in Readme
- [ ] Add Documentation examples
- [ ] Add notebook exampls via Literate.jl

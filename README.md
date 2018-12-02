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

This package provides a Julia version of MATLAB's `inpaint_nans` function (originally written by John d'Errico, available on the MathWorks [File Exchange website](https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans) and ported here with his authorization by personal communication)

Simply put, `inpaint_nans` takes a vector or a matrix `A` as input and fills its `NaN`s by solving a simple (1D or 2D) PDE.

Out of the methods available in MATLAB's `inpaint_nans`, [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) currently only implements the following methods:
    - [x] method `0`
    - [ ] method `1`
    - [ ] method `2`
    - [x] method `3` (beware: not an exact match)
    - [ ] method `4`
    - [ ] method `5`

There is currently only one test for method `0`. 
This test checks that filling the `NaN`s of a sample matrix `Z` defined by MATLAB's [`peaks`](https://www.mathworks.com/help/matlab/ref/peaks.html) function fills the `NaN`s with the same values as MATLAB's version of `inpaint_nans` does.

Suggestions, ideas, issues, and PRs welcome!

## TODOs

- [ ] Add all other methods
- [ ] improve efficiency
- [ ] Julian-ify the code
- [ ] improve documentation in Readme
- [ ] Add Documentation examples
- [ ] Add notebook exampls via Literate.jl

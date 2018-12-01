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

The goal of this package is to port MATLAB's `inpaint_nans` function (originally written by John d'Errico, available on the MathWorks [File Exchange website](https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans) and ported here with his authorization by personal communication)

`inpaint_nans` takes a vector or a matrix as input and fills the `NaN`s by solving a simple 1d or 2d PDE with a basic finite difference Laplacian operator. 

So far [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) only contains John d'Errico's method `0`, which is well suited for filling `NaN`s in a "diffusive" way.

There is only one test: I create a sample matrix `Z` defined like the `peaks` function of MATLAB, replace some values with `NaN`s, and inpaints them back.
The only test is to actually compare the MATLAB output (copy-pasted in this repo) to the Julia output.

Suggestions, ideas, issues, and PRs welcome!

## TODOs

- [ ] Add other methods
- [ ] improve efficiency
- [ ] Julian-ify the code
- [ ] improve documentation in Readme
- [ ] Add CI
- [ ] Add Documentation and examples using Documenter.jl and/or Literate.jl

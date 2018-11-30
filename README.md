# Inpaintings.jl

The goal of this package is to port MATLAB's `inpaint_nans` function (originally written by John d'Errico, available on the MathWorks [File Exchange website](https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans) and ported here with his authorization by personal communication)

`inpaint_nans` takes a vector or a matrix as input and fills the `NaN`s by solving a simple 1d or 2d PDE with a basic finite difference Laplacian operator. 

So far [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) only contains John d'Errico's method `0`, which is well suited for filling `NaN`s in a "diffusive" way.

There is only one test: I create a sample matrix `Z` defined like the `peaks` function of MATLAB, replace some values with `NaN`s, and inpaints them back.
The only test is to actually compare the MATLAB output (copy-pasted in this repo) to the Julia output.
Note there are still some differences between MATLAB's `inpaint_nans` and this package when there are some `NaN`s on the borders (tested personally but not in the current repo). 
This may be from mistakes introduced when porting the code, or it may be due to differences in MATLAB and Julia that are out of my hands.

Suggestions, ideas, issues, and PRs welcome!

## TODOs

- [ ] Add other methods
- [ ] improve efficiency
- [ ] Julian-ify the code
- [ ] improve documentation in Readme
- [ ] Add CI
- [ ] Add Documentation and examples using Documenter.jl and/or Literate.jl

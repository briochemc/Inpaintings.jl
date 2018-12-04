# Inpaintings.jl Documentation

[Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) provides a Julia version of MATLAB's `inpaint_nans` function (originally written by John d'Errico, available on the MathWorks [File Exchange website](https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans) and ported here with his authorization by personal communication).

Because Julia supports `missing` values, [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) provides a more functional `inpaint` function, which takes a vector or a matrix `A` as input and fills its `missing` or `NaN` values by solving a simple (1D or 2D) PDE.

## Usage

Use the package as you would any Julia package, via `using Inpaintings`.

```@meta
DocTestSetup = quote
    using Inpaintings
end
```

Basic usage is done by applying the function `inpaint` to an array that you want to inpaint.

The tutorial below shows the functionality of [Inpaintings.jl](https://github.com/briochemc/Inpaintings.jl) and how to use the function `inpaint`.

## Tutorial

Let `A` be a matrix of floats to which we are going to "remove" some values to inpaint
```jldoctest usage
n = 10
A = float(collect(1:n) * collect(1:n)')

# output

10×10 Array{Float64,2}:
  1.0   2.0   3.0   4.0   5.0   6.0   7.0   8.0   9.0   10.0
  2.0   4.0   6.0   8.0  10.0  12.0  14.0  16.0  18.0   20.0
  3.0   6.0   9.0  12.0  15.0  18.0  21.0  24.0  27.0   30.0
  4.0   8.0  12.0  16.0  20.0  24.0  28.0  32.0  36.0   40.0
  5.0  10.0  15.0  20.0  25.0  30.0  35.0  40.0  45.0   50.0
  6.0  12.0  18.0  24.0  30.0  36.0  42.0  48.0  54.0   60.0
  7.0  14.0  21.0  28.0  35.0  42.0  49.0  56.0  63.0   70.0
  8.0  16.0  24.0  32.0  40.0  48.0  56.0  64.0  72.0   80.0
  9.0  18.0  27.0  36.0  45.0  54.0  63.0  72.0  81.0   90.0
 10.0  20.0  30.0  40.0  50.0  60.0  70.0  80.0  90.0  100.0
```

Let us "remove" some values of `A` by replacing them with `missing`:
```jldoctest usage
Amiss = convert(Array{Union{Missing, Float64}}, A)
Amiss[1:5, [1,2,end]] .= missing # replace some values with `missing`
Amiss # Let's have a look at the new array with missing values

# output

10×10 Array{Union{Missing, Float64},2}:
   missing    missing   3.0   4.0   5.0   6.0   7.0   8.0   9.0     missing
   missing    missing   6.0   8.0  10.0  12.0  14.0  16.0  18.0     missing
   missing    missing   9.0  12.0  15.0  18.0  21.0  24.0  27.0     missing
   missing    missing  12.0  16.0  20.0  24.0  28.0  32.0  36.0     missing
   missing    missing  15.0  20.0  25.0  30.0  35.0  40.0  45.0     missing
  6.0       12.0       18.0  24.0  30.0  36.0  42.0  48.0  54.0   60.0
  7.0       14.0       21.0  28.0  35.0  42.0  49.0  56.0  63.0   70.0
  8.0       16.0       24.0  32.0  40.0  48.0  56.0  64.0  72.0   80.0
  9.0       18.0       27.0  36.0  45.0  54.0  63.0  72.0  81.0   90.0
 10.0       20.0       30.0  40.0  50.0  60.0  70.0  80.0  90.0  100.0
```

### Inpainting `missing` values

We can now inpaint the `missing` values of `A` with the simple command:
```jldoctest usage
inpaint(Amiss)

# output

10×10 Array{Union{Missing, Float64},2}:
  1.0   2.0   3.0   4.0   5.0   6.0   7.0   8.0   9.0   10.0
  2.0   4.0   6.0   8.0  10.0  12.0  14.0  16.0  18.0   20.0
  3.0   6.0   9.0  12.0  15.0  18.0  21.0  24.0  27.0   30.0
  4.0   8.0  12.0  16.0  20.0  24.0  28.0  32.0  36.0   40.0
  5.0  10.0  15.0  20.0  25.0  30.0  35.0  40.0  45.0   50.0
  6.0  12.0  18.0  24.0  30.0  36.0  42.0  48.0  54.0   60.0
  7.0  14.0  21.0  28.0  35.0  42.0  49.0  56.0  63.0   70.0
  8.0  16.0  24.0  32.0  40.0  48.0  56.0  64.0  72.0   80.0
  9.0  18.0  27.0  36.0  45.0  54.0  63.0  72.0  81.0   90.0
 10.0  20.0  30.0  40.0  50.0  60.0  70.0  80.0  90.0  100.0
```

### Cyclic dimensions

An option that may be useful is to assume that one dimension is cyclic (e.g., when mapping the globe for longitude):
```jldoctest usage
inpaint(Amiss, cycledims=[2])

# output

10×10 Array{Float64,2}:
  6.12342   3.75212   3.0   4.0   5.0   6.0   7.0   8.0   9.0    8.44909
 11.1515    7.418     6.0   8.0  10.0  12.0  14.0  16.0  18.0   15.7034
 15.4254   10.3003    9.0  12.0  15.0  18.0  21.0  24.0  27.0   23.2602
 17.668    12.0028   12.0  16.0  20.0  24.0  28.0  32.0  36.0   31.3321
 15.4959   12.1129   15.0  20.0  25.0  30.0  35.0  40.0  45.0   42.0958
  6.0      12.0      18.0  24.0  30.0  36.0  42.0  48.0  54.0   60.0
  7.0      14.0      21.0  28.0  35.0  42.0  49.0  56.0  63.0   70.0
  8.0      16.0      24.0  32.0  40.0  48.0  56.0  64.0  72.0   80.0
  9.0      18.0      27.0  36.0  45.0  54.0  63.0  72.0  81.0   90.0
 10.0      20.0      30.0  40.0  50.0  60.0  70.0  80.0  90.0  100.0
```

### Inpainting `NaN`s

If `A` is an array of floats and contains some `NaN`s rather than `missing` values, the command `inpaint(A)` will fill its `NaN`s.
First, let's create the array with `NaN`s:
```jldoctest usage
Anan = copy(A)
Anan[1:5, [1,2,end]] .= NaN # replace some values with `NaN`
Anan # Let's have a look at the new array with NaN values

# output

10×10 Array{Float64,2}:
 NaN    NaN     3.0   4.0   5.0   6.0   7.0   8.0   9.0  NaN
 NaN    NaN     6.0   8.0  10.0  12.0  14.0  16.0  18.0  NaN
 NaN    NaN     9.0  12.0  15.0  18.0  21.0  24.0  27.0  NaN
 NaN    NaN    12.0  16.0  20.0  24.0  28.0  32.0  36.0  NaN
 NaN    NaN    15.0  20.0  25.0  30.0  35.0  40.0  45.0  NaN
   6.0   12.0  18.0  24.0  30.0  36.0  42.0  48.0  54.0   60.0
   7.0   14.0  21.0  28.0  35.0  42.0  49.0  56.0  63.0   70.0
   8.0   16.0  24.0  32.0  40.0  48.0  56.0  64.0  72.0   80.0
   9.0   18.0  27.0  36.0  45.0  54.0  63.0  72.0  81.0   90.0
  10.0   20.0  30.0  40.0  50.0  60.0  70.0  80.0  90.0  100.0
```

Now, we can inpaint `Anan`'s `NaN` values via
```jldoctest usage
inpaint(Anan)

# output

10×10 Array{Float64,2}:
  1.0   2.0   3.0   4.0   5.0   6.0   7.0   8.0   9.0   10.0
  2.0   4.0   6.0   8.0  10.0  12.0  14.0  16.0  18.0   20.0
  3.0   6.0   9.0  12.0  15.0  18.0  21.0  24.0  27.0   30.0
  4.0   8.0  12.0  16.0  20.0  24.0  28.0  32.0  36.0   40.0
  5.0  10.0  15.0  20.0  25.0  30.0  35.0  40.0  45.0   50.0
  6.0  12.0  18.0  24.0  30.0  36.0  42.0  48.0  54.0   60.0
  7.0  14.0  21.0  28.0  35.0  42.0  49.0  56.0  63.0   70.0
  8.0  16.0  24.0  32.0  40.0  48.0  56.0  64.0  72.0   80.0
  9.0  18.0  27.0  36.0  45.0  54.0  63.0  72.0  81.0   90.0
 10.0  20.0  30.0  40.0  50.0  60.0  70.0  80.0  90.0  100.0
```

### Inpainting any value

Instead of inpainting `missing` or `NaN` values, we sometimes want to inpaint a specific value.
This is done by giving the value after the array as an argument, via the syntax `inpaint(A, value_to_inpaint)`.
To check this, let's add a bunch of `12345` to our array:
```jldoctest usage
A12345 = copy(A)
A12345[1:5, [1,2,end]] .= 12345 # replace some values with `12345`
A12345 # Let's have a look at the new array with NaN values

# output

10×10 Array{Float64,2}:
 12345.0  12345.0   3.0   4.0   5.0   6.0   7.0   8.0   9.0  12345.0
 12345.0  12345.0   6.0   8.0  10.0  12.0  14.0  16.0  18.0  12345.0
 12345.0  12345.0   9.0  12.0  15.0  18.0  21.0  24.0  27.0  12345.0
 12345.0  12345.0  12.0  16.0  20.0  24.0  28.0  32.0  36.0  12345.0
 12345.0  12345.0  15.0  20.0  25.0  30.0  35.0  40.0  45.0  12345.0
     6.0     12.0  18.0  24.0  30.0  36.0  42.0  48.0  54.0     60.0
     7.0     14.0  21.0  28.0  35.0  42.0  49.0  56.0  63.0     70.0
     8.0     16.0  24.0  32.0  40.0  48.0  56.0  64.0  72.0     80.0
     9.0     18.0  27.0  36.0  45.0  54.0  63.0  72.0  81.0     90.0
    10.0     20.0  30.0  40.0  50.0  60.0  70.0  80.0  90.0    100.0
```

Now, we can inpaint the `12345` values via
```jldoctest usage
inpaint(A12345, 12345)

# output

10×10 Array{Float64,2}:
  1.0   2.0   3.0   4.0   5.0   6.0   7.0   8.0   9.0   10.0
  2.0   4.0   6.0   8.0  10.0  12.0  14.0  16.0  18.0   20.0
  3.0   6.0   9.0  12.0  15.0  18.0  21.0  24.0  27.0   30.0
  4.0   8.0  12.0  16.0  20.0  24.0  28.0  32.0  36.0   40.0
  5.0  10.0  15.0  20.0  25.0  30.0  35.0  40.0  45.0   50.0
  6.0  12.0  18.0  24.0  30.0  36.0  42.0  48.0  54.0   60.0
  7.0  14.0  21.0  28.0  35.0  42.0  49.0  56.0  63.0   70.0
  8.0  16.0  24.0  32.0  40.0  48.0  56.0  64.0  72.0   80.0
  9.0  18.0  27.0  36.0  45.0  54.0  63.0  72.0  81.0   90.0
 10.0  20.0  30.0  40.0  50.0  60.0  70.0  80.0  90.0  100.0
```


### Inpainting any value `x` such that `f(x) == true`

Another approach is to inpaint values for which a function `f` returns `true`.
`f` must be a function that has one scalar argument and that returns a boolean.
For example, we can reproduces the examples above by using the functions `ismissing`, `isnan`, or `x -> x == 12345`.
Let's assume for some reason all the values of `A` that are above `10` were too high:
```jldoctest usage
A10 = copy(A)
A10[findall(A10 .> 10)] .= 1e3
A10

# output

10×10 Array{Float64,2}:
  1.0     2.0     3.0     4.0     5.0     6.0     7.0     8.0     9.0    10.0
  2.0     4.0     6.0     8.0    10.0  1000.0  1000.0  1000.0  1000.0  1000.0
  3.0     6.0     9.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0
  4.0     8.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0
  5.0    10.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0
  6.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0
  7.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0
  8.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0
  9.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0
 10.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0  1000.0
```

We can inpaint those values via
```jldoctest usage
inpaint(x -> x .> 10, A10)

# output

10×10 Array{Float64,2}:
  1.0   2.0   3.0   4.0   5.0   6.0   7.0   8.0   9.0   10.0
  2.0   4.0   6.0   8.0  10.0  12.0  14.0  16.0  18.0   20.0
  3.0   6.0   9.0  12.0  15.0  18.0  21.0  24.0  27.0   30.0
  4.0   8.0  12.0  16.0  20.0  24.0  28.0  32.0  36.0   40.0
  5.0  10.0  15.0  20.0  25.0  30.0  35.0  40.0  45.0   50.0
  6.0  12.0  18.0  24.0  30.0  36.0  42.0  48.0  54.0   60.0
  7.0  14.0  21.0  28.0  35.0  42.0  49.0  56.0  63.0   70.0
  8.0  16.0  24.0  32.0  40.0  48.0  56.0  64.0  72.0   80.0
  9.0  18.0  27.0  36.0  45.0  54.0  63.0  72.0  81.0   90.0
 10.0  20.0  30.0  40.0  50.0  60.0  70.0  80.0  90.0  100.0
```




## Functions

```@autodocs
Modules = [Inpaintings]
Order   = [:function, :type]
```


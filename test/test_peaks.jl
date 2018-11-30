# This uses MATLAB's definition of the `peaks` function to test `inpaint_nans`

peaks(x, y) = 3 * (1 - x)^2 * exp(-(x^2) - (y + 1)^2) -
    10 * (x/5 - x^3 - y^5) * exp(-x^2 - y^2) -
    1/3 * exp(-(x + 1)^2 - y^2)

xs = -3:0.1:3
ys = -2.5:0.1:2.5
Z = [peaks(x, y) for x in xs, y in ys]

# Remove some values in blocks
Z_with_NaNs = copy(Z)
Z_with_NaNs[2:10, 2:10] .= NaN
Z_with_NaNs[20:40, 20:35] .= NaN
# Remove some values at random indices (pregenerated for determinism of the test)
idx = [
    CartesianIndex(53, 49)
    CartesianIndex(39, 15)
    CartesianIndex(33, 45)
    CartesianIndex(18, 41)
    CartesianIndex(53, 51)
    CartesianIndex(35, 8)
    CartesianIndex(12, 31)
    CartesianIndex(57, 48)
    CartesianIndex(29, 51)
    CartesianIndex(35, 3)
    CartesianIndex(50, 16)
    CartesianIndex(3, 5)
    CartesianIndex(32, 23)
    CartesianIndex(8, 38)
    CartesianIndex(48, 19)
    CartesianIndex(28, 45)
    CartesianIndex(23, 15)
    CartesianIndex(49, 45)
    CartesianIndex(45, 44)
    CartesianIndex(33, 6)
    CartesianIndex(20, 34)
    CartesianIndex(49, 28)
    CartesianIndex(30, 22)
    CartesianIndex(18, 51)
    CartesianIndex(30, 6)
    CartesianIndex(53, 18)
    CartesianIndex(44, 38)
    CartesianIndex(31, 25)
    CartesianIndex(30, 5)
    CartesianIndex(15, 19)
]
Z_with_NaNs[idx] .= NaN

Z_reconstructed = inpaint_nans(Z_with_NaNs)

using Plots
contourf(ys, xs, Z)
contourf(ys, xs, Z_with_NaNs)
contourf(ys, xs, Z_reconstructed)

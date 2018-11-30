"""
    inpaint_nans(A, method=0)

Inpaints `NaN` values by solving a diffusion PDE for the standard Laplacian.
Inspired by MATLAB's `inpaint_nans`'s (by John d'Errico).
See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans.
Currently only method `0` is implemented.
"""
function inpaint_nans(A, method=0)
    # TODO add other methods from John d'Errico's MATLAB's `inpaint_nans`.
    return @match method begin
        0 => inpaint_nans_method0(A)
        6 => inpaint_nans_method6(A)
        _ => error("Method $method not available yet. Suggest it on Github!")
    end
end


"""
    inpaint_nans_method0(A::Vector)

Inpaints `NaN` values by solving a diffusion PDE for the standard Laplacian.
Inspired by MATLAB's `inpaint_nans`'s method `0` for vectors (by John d'Errico).
See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans.
"""
function inpaint_nans_method0(A::Vector)
    inan = findall(@. isnan(A))
    inotnan = findall(@. !isnan(A))

    # The Laplacian is applied to the non-NaN neighbors
    iwork = unique(sort([inan..., (inan .- 1)..., (inan .+ 1)...]))
    iwork = iwork[findall(1 .< iwork .< length(A))]
    nw = length(iwork)
    u = collect(1:nw)

    # Build the Laplacian (not the fastest way but easier-to-read code)
    Δ =  sparse(u, iwork     , -2.0, nw, length(A))
    Δ += sparse(u, iwork .- 1, +1.0, nw, length(A))
    Δ += sparse(u, iwork .+ 1, +1.0, nw, length(A))

    # knowns to right hand side
    rhs = -Δ[:, inotnan] * A[inotnan]

    # and solve...
    B = copy(A)
    B[inan] .= Δ[:, inan] \ rhs
    return B
end

"""
    list_neighbors(A, idx, neighbors)

Lists all the "strict" neighbors of the indices in `idx` in Array `A`.
"strict" here means that neighbors already in `idx` are rejected.
The argument `neighnors` contains a list of the neighbors about the
origin coordinate `(0, 0, ...)`.
In other words, it is a `Vector` of `CartesianIndex` such that
the direct neighbors of index `i` are given by `i + n for n in neighbors`.
Inspired by MATLAB's `inpaint_nans`'s `identify_neighbors` (by John d'Errico).
See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans.
"""
function list_neighbors(R, idx, neighbors)
    out = [i + n for i in idx for n in neighbors
        if i + n ∈ R && i + n ∉ idx]
    out = sort(unique(out))
end

"""
    inpaint_nans_method0(A::Array{T,2}) where T

Inpaints `NaN` values by solving a diffusion PDE for the standard Laplacian.
Inspired by MATLAB's `inpaint_nans`'s method `0` for matrices (by John d'Errico).
See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans.
"""
function inpaint_nans_method0(A::Array{T,2}) where T
    Inan = findall(@. isnan(A))
    Inotnan = findall(@. !isnan(A))

    # horizontal and vertical neighbors only
    N1 = CartesianIndex(1, 0)
    N2 = CartesianIndex(0, 1)
    neighbors = [N1, -N1, N2, -N2]

    # list of strict neighbors
    R = CartesianIndices(size(A))
    Ineighbors = list_neighbors(R, Inan, neighbors)

    # list of all nodes we have identified
    Iwork = [Inan; Ineighbors]
    # Remove borders (Von-Neuman boundary)
    R₂ = CartesianIndices(size(A) .- 2)
    R₂ = [r₂ + first(R₂) for r₂ in R₂]
    Iwork = [w for w in Iwork if w ∈ R₂]
    # Sort it (not sure the sorting is required)
    Iwork = sort(Iwork)
    nw = length(Iwork)
    u = collect(1:nw)

    # Use Linear indices to generate the sparse Laplacian
    iwork = LinearIndices(size(A))[Iwork]
    n1 = LinearIndices(size(A))[first(R) + N1] - LinearIndices(size(A))[first(R)]
    n2 = LinearIndices(size(A))[first(R) + N2] - LinearIndices(size(A))[first(R)]

    # Build the Laplacian (not the fastest way but easier-to-read code)
    Δ =  sparse(u, iwork      , -4.0, nw, length(A))
    Δ += sparse(u, iwork .- n1, +1.0, nw, length(A))
    Δ += sparse(u, iwork .+ n1, +1.0, nw, length(A))
    Δ += sparse(u, iwork .- n2, +1.0, nw, length(A))
    Δ += sparse(u, iwork .+ n2, +1.0, nw, length(A))

    # Use Linear indices to access the sparse Laplacian
    inan = LinearIndices(size(A))[Inan]
    inotnan = LinearIndices(size(A))[Inotnan]

    # knowns to right hand side
    rhs = -Δ[:, inotnan] * A[inotnan]

    # and solve...
    B = copy(A)
    B[inan] .= Δ[:, inan] \ rhs
    return B
end

"""
    inpaint_nans_method6(A::Array{T,2}) where T

Inpaints `NaN` values by solving a diffusion PDE for a diagonally filled Laplacian:
```math
\mathbf{D}_{xy}^{2} = \begin{bmatrix}0.25&0.5&0.25\\0.5&-3&0.5\\0.25&0.5&0.25\end{bmatrix}
```
Inspired by MATLAB's `inpaint_nans`'s method `0` for matrices (by John d'Errico).
See https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans.
"""
function inpaint_nans_method6(A::Array{T,2}) where T
    Inan = findall(@. isnan(A))
    Inotnan = findall(@. !isnan(A))

    # direct and diagonal neighbors
    N0 = CartesianIndex(0, 0)
    N1 = CartesianIndex(1, 0)
    N2 = CartesianIndex(0, 1)
    neighbors = sort([n1 + n2 for n1 in (-N1, N0, N1), n2 in (-N2, N0, N2) if n1 + n2 ≠ N0])

    # list of strict neighbors
    R = CartesianIndices(size(A))
    Ineighbors = list_neighbors(R, Inan, neighbors)

    # list of all nodes we have identified
    Iwork = [Inan; Ineighbors]
    # Remove borders (Von-Neuman boundary)
    R₂ = CartesianIndices(size(A) .- 2)
    R₂ = [r₂ + first(R₂) for r₂ in R₂]
    Iwork = [w for w in Iwork if w ∈ R₂]
    # Sort it (not sure the sorting is required)
    Iwork = sort(Iwork)
    nw = length(Iwork)
    u = collect(1:nw)

    # Use Linear indices to generate the sparse Laplacian
    iwork = LinearIndices(size(A))[Iwork]
    n1 = LinearIndices(size(A))[first(R) + N1] - LinearIndices(size(A))[first(R)]
    n2 = LinearIndices(size(A))[first(R) + N2] - LinearIndices(size(A))[first(R)]

    # Build the Laplacian (not the fastest way but easier-to-read code)
    Δ =  sparse(u, iwork      , -3.0, nw, length(A))
    Δ += sparse(u, iwork .- n1, +0.5, nw, length(A))
    Δ += sparse(u, iwork .+ n1, +0.5, nw, length(A))
    Δ += sparse(u, iwork .- n2, +0.5, nw, length(A))
    Δ += sparse(u, iwork .+ n2, +0.5, nw, length(A))
    Δ += sparse(u, iwork .- (n1 + n2), +0.25, nw, length(A))
    Δ += sparse(u, iwork .+ (n1 + n2), +0.25, nw, length(A))
    Δ += sparse(u, iwork .- (n1 - n2), +0.25, nw, length(A))
    Δ += sparse(u, iwork .+ (n1 - n2), +0.25, nw, length(A))

    # Use Linear indices to access the sparse Laplacian
    inan = LinearIndices(size(A))[Inan]
    inotnan = LinearIndices(size(A))[Inotnan]

    # knowns to right hand side
    rhs = -Δ[:, inotnan] * A[inotnan]

    # and solve...
    B = copy(A)
    B[inan] .= Δ[:, inan] \ rhs
    return B
end

export inpaint_nans


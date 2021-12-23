export errinros_mod

function errinros_mod(; n::Int = default_nvar, type::Val{T} = Val(Float64), kwargs...) where {T}
  n < 2 && @warn("errinros_mod: number of variables must be ≥ 2")
  n = max(2, n)
  function f(x)
    n = length(x)
    return sum((x[i - 1] - 16 * x[i]^2 * T(1.5 + sin(i))^2)^2 for i = 2:n) +
           sum((1 - x[i])^2 for i = 2:n)
  end
  x0 = -ones(T, n)
  return ADNLPModels.ADNLPModel(f, x0, name = "errinros"; kwargs...)
end
### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 3f81827e-8542-11eb-3fdb-af257b179464
begin
    using PlutoUI
    using Images
    using Plots
    gr()  
end

# ╔═╡ 7ad690f2-8542-11eb-0071-a140a59c51f6
function bucket_state_step(v, Δt, C, λ, v0, u)
Δv = (u - λ*(v - v0))*Δt/C
end

# ╔═╡ b2986680-8542-11eb-3879-2748309e73a3
@bind r Slider(5:5:100)

# ╔═╡ c3cda770-8543-11eb-0696-25c948443592
md" r = $r"

# ╔═╡ c12d9da0-8542-11eb-1666-57688fa07eac
@bind λ_ Slider(5:5:100)

# ╔═╡ b704cbe0-8543-11eb-0d31-5f6a3d4e7731
md" λ = $λ_"

# ╔═╡ d2f92090-8542-11eb-280b-91da6301ef67
@bind u_ Slider(-500:5:500)

# ╔═╡ a8f4a340-8543-11eb-2fca-4da15f5bff05
md" u = $u_"

# ╔═╡ 822b8cc0-8542-11eb-01e4-51b7e04d38e4
begin
C = π*r^2
λ = λ_
Δt = 0.05 # simulate in 50ms steps
T = 1200.0 # duration of simulation in seconds
t = 0:Δt:T; # time iterator
v = zeros(length(t)) # vector container for computed level
v[1] = 10.0 # initial height (initial condition/state)
v_rest = 10.0 # leak height
u = u_ # input current
end

# ╔═╡ d75950f2-8543-11eb-12a4-bb77a94a50a8
begin
for i in 2:length(t)
v[i] = v[i-1] + bucket_state_step(v[i-1], Δt, C, λ, v_rest, u)
end
plot(t,v, label = "water level")
end

# ╔═╡ Cell order:
# ╠═3f81827e-8542-11eb-3fdb-af257b179464
# ╠═7ad690f2-8542-11eb-0071-a140a59c51f6
# ╟─c3cda770-8543-11eb-0696-25c948443592
# ╠═b2986680-8542-11eb-3879-2748309e73a3
# ╟─b704cbe0-8543-11eb-0d31-5f6a3d4e7731
# ╠═c12d9da0-8542-11eb-1666-57688fa07eac
# ╟─a8f4a340-8543-11eb-2fca-4da15f5bff05
# ╠═d2f92090-8542-11eb-280b-91da6301ef67
# ╠═822b8cc0-8542-11eb-01e4-51b7e04d38e4
# ╠═d75950f2-8543-11eb-12a4-bb77a94a50a8

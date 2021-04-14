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

# ╔═╡ 95893480-82e9-11eb-3360-4b51ef36cbc0
begin
    using PlutoUI
    using Images
	using ImageMagick
    using Plots
    gr()  
end

# ╔═╡ 0151cc70-8cfb-11eb-059e-13d432ec74d5
function bucket_state_step(v, Δt, C, λ, v0, u)
Δv = (u - λ*(v - v0))*Δt/C
end


# ╔═╡ 3d335420-853f-11eb-2db9-4b2cb53244bd
md" A1"

# ╔═╡ 032a1a00-83a7-11eb-0d68-cd91cbb704f9
@bind τ_ Slider(5:5:1000)

# ╔═╡ 47006f40-83a7-11eb-1abc-8fa3c649b81d
md" τ = $τ_"

# ╔═╡ 8d6c5090-83b4-11eb-3ae5-cf2199149ae8
@bind r Slider(5:5:100)

# ╔═╡ d21deaa0-83b4-11eb-22be-699fa422cf23
md" r = $r"

# ╔═╡ bf021e30-82e9-11eb-0e10-4d69184360a4
@bind λ_ Slider(5:5:25)

# ╔═╡ 94525b30-8cfa-11eb-3c39-d57db1ff6f8d
begin
C = π*r^2
λ = λ_
Δt = 0.05 # simulate in 50ms steps
T = 600.0 # duration of simulation in seconds
t = 0:Δt:T; # time iterator
v = zeros(length(t)) # vector container for computed level
v[1] = 10.0 # initial height (initial condition/state)
v_rest = 1.0 # leak height
	u = 0.0
end

# ╔═╡ c7caf550-82e9-11eb-18f1-c5bef467a0d0
begin
md" λ = $λ_"
end

# ╔═╡ 4441b500-8e8a-11eb-3ae6-736056ba3fcb
begin
	τ = τ_
	plot(t,v[1]*exp.(-t./τ),
xlabel = "seconds", ylabel = "v-v0", label = "exponential")
	plot!(t,v, label = "water level")
	end

# ╔═╡ 4657b8c0-853f-11eb-096b-a738bafc5cf8
md" A1.1"

# ╔═╡ ac08a590-8539-11eb-0df8-87209c6a4bb1
md" as tau increases, lambda decreases and/or C increases"

# ╔═╡ 5d2b20f0-8544-11eb-0052-4db09e185ea1
md" tau and lambda are inversely proportional while tau and C are directly proportional"

# ╔═╡ 656bdde0-8cfb-11eb-08db-095988d2a954
	tau = R*C
	R = 1/lambda

# ╔═╡ 4ded4002-853f-11eb-0436-155c7572665b
md" A1.2"

# ╔═╡ 950e1740-853d-11eb-38d7-897a2f00e2a6
md" at t=τ the water column is 36.8% (0.36787944117 = 1/e) of its initial height above the leak channel"

# ╔═╡ cfc31520-853d-11eb-1bd4-6ffed3fbb589
md" when τ=300 and t=300, and when τ=200 and t=200, and when τ=100 and t=100, approximately 4.05cm out of 11cm remains, 4.05/11 = 0.368."

# ╔═╡ 586336a0-82e9-11eb-3bd2-dff712732946
function bucket_state_step1(v1, Δt1, C1, λ1, v01, u1)
Δv1 = (u1 - λ1*(v1 - v01))*Δt1/C1
end

# ╔═╡ 89643a10-82e9-11eb-0e59-9d44c7acf15c
begin
C1 = π*r^2
λ1 = λ_
Δt1 = 0.05 # simulate in 50ms steps
T1 = 600.0 # duration of simulation in seconds
t1 = 0:Δt1:T1; # time iterator
v1 = zeros(length(t1)) # vector container for computed level
v1[1] = 50.0 # initial height (initial condition/state)
v_rest1 = 50.0 # leak height
u1 = zeros(length(t1))
for i in 600:1200
	u1[i] = 1.0
for i in 6000:6600
	u1[i] = -1.0
end
end
end

# ╔═╡ 244d94e0-8e89-11eb-3d13-5b376f909d4d
md" A2"

# ╔═╡ 144fee50-879d-11eb-0bbf-07f9f1261456
@bind u_ Slider(-300.0:5.0:300.0)

# ╔═╡ 7bd48e20-86f1-11eb-2571-2fbdad618088
md" u = $u_"

# ╔═╡ 914c4e20-82e9-11eb-0c36-2b190e07cc01
begin
for i in 2:length(t1)
v1[i] = v1[i-1] + bucket_state_step1(v1[i-1], Δt1, C1, λ1, v_rest1, u1[i]*u_)
end	
plot(t1,v1, xlabel = "seconds", ylabel = "cm", label = "water level")
end


# ╔═╡ Cell order:
# ╠═95893480-82e9-11eb-3360-4b51ef36cbc0
# ╠═0151cc70-8cfb-11eb-059e-13d432ec74d5
# ╠═94525b30-8cfa-11eb-3c39-d57db1ff6f8d
# ╟─3d335420-853f-11eb-2db9-4b2cb53244bd
# ╟─47006f40-83a7-11eb-1abc-8fa3c649b81d
# ╠═032a1a00-83a7-11eb-0d68-cd91cbb704f9
# ╟─d21deaa0-83b4-11eb-22be-699fa422cf23
# ╠═8d6c5090-83b4-11eb-3ae5-cf2199149ae8
# ╟─c7caf550-82e9-11eb-18f1-c5bef467a0d0
# ╠═bf021e30-82e9-11eb-0e10-4d69184360a4
# ╠═4441b500-8e8a-11eb-3ae6-736056ba3fcb
# ╟─4657b8c0-853f-11eb-096b-a738bafc5cf8
# ╟─ac08a590-8539-11eb-0df8-87209c6a4bb1
# ╟─5d2b20f0-8544-11eb-0052-4db09e185ea1
# ╠═656bdde0-8cfb-11eb-08db-095988d2a954
# ╟─4ded4002-853f-11eb-0436-155c7572665b
# ╟─950e1740-853d-11eb-38d7-897a2f00e2a6
# ╟─cfc31520-853d-11eb-1bd4-6ffed3fbb589
# ╠═586336a0-82e9-11eb-3bd2-dff712732946
# ╠═89643a10-82e9-11eb-0e59-9d44c7acf15c
# ╟─244d94e0-8e89-11eb-3d13-5b376f909d4d
# ╟─7bd48e20-86f1-11eb-2571-2fbdad618088
# ╟─144fee50-879d-11eb-0bbf-07f9f1261456
# ╠═914c4e20-82e9-11eb-0c36-2b190e07cc01

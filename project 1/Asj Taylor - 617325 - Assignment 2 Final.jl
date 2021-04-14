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

# ╔═╡ d4612760-8e8a-11eb-30f2-cb9daa2eb297
begin
    using PlutoUI
    using Images
	using ImageMagick
    using Plots
    gr()  
end

# ╔═╡ 93571180-8e8a-11eb-11da-ad003a6d6aa6
md" A1: Plot an exponential curve with paramter τ and the numerical solution of the leaky bucket model with parameters C and λ on the same axes, with u = 0 and the same initial state"

# ╔═╡ 0ff7aba0-8e8b-11eb-0c57-7d790db793ff
function bucket_state_step(v, Δt, C, λ, v0, u) # set up function bucket_state_step with paramaters v, Δt, C, λ, v0, u
Δv = (u - λ*(v - v0))*Δt/C # such that Δv = (u - λ*(v - v0))*Δt/C
end

# ╔═╡ afa6baae-8e8b-11eb-1072-2721a809570a
@bind r Slider(1:1:100)

# ╔═╡ 5caafc40-8e8b-11eb-392c-ad78f7c8b94a
begin #establish first set of parameters for first plot
C = π*r^2 # C = pi*radius^2 where radius = r slider value
Δt = 0.05 # simulate in 50ms steps
T = 600.0 # duration of simulation in seconds
t = 0:Δt:T; # time iterator from 0 seconds to 600 seconds in 50ms steps
v = zeros(length(t)) # vector container for computed water level
v[1] = 11.0 # initial height = 11.0cm
v_rest = 0.0 # leak height = 0.0cm
u = 0.0 # input current = 0.0
end

# ╔═╡ da6f0390-8e92-11eb-302b-5973e7822095
md" C = $(π*r^2)"

# ╔═╡ bb4d5d60-8e8b-11eb-1691-fbffdfec396d
md" r slider,
r = $r"

# ╔═╡ ccade980-8e8b-11eb-3cd2-fddae5ff9540
@bind λ Slider(1:1:25)

# ╔═╡ d0cfcdd0-8e8b-11eb-2b69-57c0902cf075
md" λ slider, λ = $λ"

# ╔═╡ fa0cbff0-8e8b-11eb-29fc-f32aae1cb9c8
@bind τ Slider(5:5:1000)

# ╔═╡ 01da6e30-8e8c-11eb-393f-2591b1b8f5d5
md" τ slider, τ = $τ"

# ╔═╡ 2bcc3162-8e8c-11eb-1d2d-798cbe6e9fa1
begin 
	plot(t, v[1]*exp.(-t./τ), # plot time iterator vs exponential curve mulitplied by initial height
		xlabel = "Time seconds", ylabel = "Height (cm)", label = "exponential", title = "Exponential curve and water level")
for i in 2:length(t) # for each iteration from the 2nd to the last iterations
v[i] = v[i-1] + bucket_state_step(v[i-1], Δt, C, λ, v_rest, u) # each iteration of v = the previous iteration + the bucket_state_step function
end
plot!(t,v, label = "water level") # add a plot of the time iterator vs water level to the same axes
end

# ╔═╡ 6dfa9110-8e8e-11eb-3689-77aeae7ef4dd
md""" A1.1: What is the relationship of the time constant τ of the analytical solution to the "biophysical" parameters C and λ? (Show this empirically)"""

# ╔═╡ b44c6da0-8e8e-11eb-1657-332d63f78ff7
md" By observation, as τ increases, C increases and/or λ decreases."

# ╔═╡ d9b30360-8e8e-11eb-1aaa-15690a4b6cff
md" τ and C are directly proportional (τ = R*C) while τ and λ are inversely proportional (since R = 1/λ)."

# ╔═╡ edef5f40-8e8e-11eb-1178-cd94a8e85a17
md" A1.2: What is the height of the water column above the leak channel at time t=τ relative to its initial height? (show this analytically and confirm by simulation)"

# ╔═╡ d6c3442e-8e93-11eb-25c2-e724b14d307b
md" Analytically: at t=τ the water column is 36.8% (0.36787944117 = 1/e) of its initial height above the leak channel"	

# ╔═╡ 125cfcc0-8e94-11eb-08fc-ff63ddf80556
	
	md" By simulation: when τ=300 and t=300, and when τ=200 and t=200, and when τ=100 and t=100, approximately 4.05cm out of 11cm remains, 4.05/11 = 0.368."

# ╔═╡ 4e79a0f0-8e94-11eb-35d8-8500b7d2ba66
md""" A2: Create an interactive simulation of a leaky bucket neuron that starts at rest potential and receives
a 30-second burst of "synaptic input" after 30 seconds. Use a slider to control the amplitude of the
input current. Allow the input to be positive or negative, ie it is possible to suck water out of the
bucket. Assume that the bucket is tall enough and the leak channel is far enough up the side that the
bucket cannot run dry or overflow. Note that water will leak backwards through the leak channel, into
the bucket, if the water level drops below the channel. Note that we are starting to stretch the analogy
between buckets and neurons. Soon it will break."""

# ╔═╡ ad9f6610-8e98-11eb-126d-e9a4f0725b16
function bucket_state_step_(v_, Δt_, C_, λ_, v0_, u_) # set up function bucket_state_step_ with parameters v_, Δt_, C_, λ_, v0_, u_
Δv_ = (u_ - λ_*(v_ - v0_))*Δt_/C_ # such that Δv_ = (u_ - λ_*(v_ - v0_))*Δt_/C_
end

# ╔═╡ ec7c3bb2-8e98-11eb-2f59-35f3b85bbfd0
begin #establish second set of parameters for second plot
C_ = π*5.0^2 # C_ = pi*radius^2 where radius = 5.0
λ_ = 5.0 # λ_ = 5.0
Δt_ = 0.05 # simulate in 50ms steps
T_ = 600.0 # duration of simulation in seconds
t_ = 0:Δt_:T_; # time iterator from 0 seconds to 600 seconds in 50ms steps
v_ = zeros(length(t_)) # vector container for computed water level
v_[1] = 50.0 # initial height = 50.0cm
v_rest_ = 50.0 # leak height = 50.0cm
u_ = zeros(length(t_)) # vector container for variable input
	for i in 600:1200 # between 30 seconds and 60 seconds
		u_[i] = 1.0 # input is 1.0*"the value of the u slider"
	for i in 6000:6600 # between 300 and 330 seconds
		u_[i] = -1.0 # input is -1.0*"the value of the u slider"
		end
	end
end

# ╔═╡ a60d6bd0-8e99-11eb-0bf9-c12839b693ac
@bind u__ Slider(-300.0:1.0:300.0)

# ╔═╡ 350a7e40-8e9a-11eb-2b66-4358e880c01b
md" u slider, u = $u__"

# ╔═╡ 4242483e-8e9a-11eb-13ee-17003219f0af
begin
	for i in 2:length(t_) # for each iteration from the 2nd to the last iterations
		v_[i] = v_[i-1] + bucket_state_step_(v_[i-1], Δt_, C_, λ_, v_rest_, u_[i]*u__) # each iteration of v_ = the previous iteration + the bucket_state_step_ function where the input is 1.0*"the value of the u slider" for 30s < t < 60s and -1.0*"the value of the u slider" for 300s < t < 330s
	end
	plot(t_,v_, xlabel = "Time (seconds)", ylabel = "Height (cm)", label = "water level", title = "Water level over time") # plot t_ vs v_
end

# ╔═╡ Cell order:
# ╠═d4612760-8e8a-11eb-30f2-cb9daa2eb297
# ╟─93571180-8e8a-11eb-11da-ad003a6d6aa6
# ╠═0ff7aba0-8e8b-11eb-0c57-7d790db793ff
# ╠═5caafc40-8e8b-11eb-392c-ad78f7c8b94a
# ╠═da6f0390-8e92-11eb-302b-5973e7822095
# ╟─bb4d5d60-8e8b-11eb-1691-fbffdfec396d
# ╟─afa6baae-8e8b-11eb-1072-2721a809570a
# ╟─d0cfcdd0-8e8b-11eb-2b69-57c0902cf075
# ╟─ccade980-8e8b-11eb-3cd2-fddae5ff9540
# ╟─01da6e30-8e8c-11eb-393f-2591b1b8f5d5
# ╟─fa0cbff0-8e8b-11eb-29fc-f32aae1cb9c8
# ╠═2bcc3162-8e8c-11eb-1d2d-798cbe6e9fa1
# ╟─6dfa9110-8e8e-11eb-3689-77aeae7ef4dd
# ╟─b44c6da0-8e8e-11eb-1657-332d63f78ff7
# ╟─d9b30360-8e8e-11eb-1aaa-15690a4b6cff
# ╟─edef5f40-8e8e-11eb-1178-cd94a8e85a17
# ╟─d6c3442e-8e93-11eb-25c2-e724b14d307b
# ╟─125cfcc0-8e94-11eb-08fc-ff63ddf80556
# ╟─4e79a0f0-8e94-11eb-35d8-8500b7d2ba66
# ╠═ad9f6610-8e98-11eb-126d-e9a4f0725b16
# ╠═ec7c3bb2-8e98-11eb-2f59-35f3b85bbfd0
# ╟─350a7e40-8e9a-11eb-2b66-4358e880c01b
# ╟─a60d6bd0-8e99-11eb-0bf9-c12839b693ac
# ╠═4242483e-8e9a-11eb-13ee-17003219f0af

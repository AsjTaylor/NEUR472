### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# ╔═╡ 6c451a9e-98db-11eb-2fc2-d1dbe15ec455
begin
    using PlutoUI
    using Images
    using Plots
    gr()  
end

# ╔═╡ 316498ac-b133-4c4a-bc33-466b67e78bf3
begin
g_Na = 1.0e-11 # single sodium channel conductance ~10pS
E_Na = 115.0 # sodium reversal potential (leak height)
g_K = 1.5e-11 # single potassium channel conductance ~15pS
E_K = -12.0 # potassium reversal potential
g_L = 2.0e-12 # single leak channel conductance ~2pS
E_L = 10.6 # leak reversal potential
end

# ╔═╡ 3d277b2f-aa93-4b13-892e-4331823d725a
begin
Δx = 1 
X = 175
x = -75:Δx:X; 
Nav = zeros(length(x))
Nav = g_Na*x.-1.15e-9
Kv = zeros(length(x))
Kv = g_K*x.+1.8e-10
Lv = zeros(length(x))
Lv = g_L*x.-2.12e-11
end

# ╔═╡ c1d4b350-7f15-4b4e-be51-8c36eb12e448
begin
plot(x, Nav, xlims = (-75, 175), ylims = (-2e-9, 3e-9), grid = false, framestyle = :origin, label = "Nav", legend=:topleft, title = "Single channel current-voltage plots", ylabel = "Current (A)", xlabel = "Voltage (mV)")
plot!(x, Kv, label = "Kv")
plot!(x, Lv, label = "Leak")
end

# ╔═╡ 70c34a4f-4856-4603-a1ee-b884c4a29b04
begin
a_n(v) = v == 10.0 ? 0.1 : 0.01*(10.0 - v)/(exp((10.0-v)/10)-1.0)
b_n(v) = 0.125*exp(-v/80.)
t_n(v) = 1.0/(a_n(v) + b_n(v))
n_infinity(v) = a_n(v)*t_n(v)
a_m(v) = v == 25.0 ? 1.0 : 0.1*(25.0 - v)/(exp((25.0-v)/10)-1.0)
b_m(v) = 4.0*exp(-v/18.)
t_m(v) = 1.0/(a_m(v) + b_m(v))
m_infinity(v) = a_m(v)*t_m(v)
a_h(v) = 0.07*exp(-v/20.)
b_h(v) = 1.0/(exp((30.0-v)/10)+1.0)
t_h(v) = 1.0/(a_h(v) + b_h(v))
h_infinity(v) = a_h(v)*t_h(v)
end

# ╔═╡ ffb0078f-6993-4949-843f-feec93dffdd0
begin
	Δv = 1 
	V = 150
	v = -50:Δv:V; 
	plot(v, n_infinity, label = "Potassium", legend =:right, title = "Voltage-gated channel activation", ylabel = "Probability", xlabel = "Voltage (mV)")
	plot!(v, m_infinity, label = "Sodium")
	plot!(v, h_infinity, label = "Na-inactivation")
end

# ╔═╡ 2bcc1de3-ff8e-4720-8fd9-41aa9ab4076e
begin
	plot(v,t_n, label = "Potassium", xlabel = "Voltage (mV)", ylabel = "Time (ms)", grid = false)
	plot!(v, t_m, label = "Sodium")
	plot!(v, t_h, label = "Sodium inactivation")
end

# ╔═╡ bc69dccb-7fb0-44b7-a9c6-3f77b689ec27
begin
# membrane conductance consts in mS/cm^2
gstar_Na = 120.
gstar_K = 36.
gstar_L = 0.3
# cell diameter 500um (nb insanely big! This is squid giant neuron)
d = 50.0e-3 # in cm
A = pi*d^2 # membrane area
# cell conductance in mS
gbar_Na = A*gstar_Na
gbar_K = A*gstar_K
gbar_L = A*gstar_L
end

# ╔═╡ Cell order:
# ╠═6c451a9e-98db-11eb-2fc2-d1dbe15ec455
# ╠═316498ac-b133-4c4a-bc33-466b67e78bf3
# ╠═3d277b2f-aa93-4b13-892e-4331823d725a
# ╠═c1d4b350-7f15-4b4e-be51-8c36eb12e448
# ╠═70c34a4f-4856-4603-a1ee-b884c4a29b04
# ╠═ffb0078f-6993-4949-843f-feec93dffdd0
# ╠═2bcc1de3-ff8e-4720-8fd9-41aa9ab4076e
# ╠═bc69dccb-7fb0-44b7-a9c6-3f77b689ec27

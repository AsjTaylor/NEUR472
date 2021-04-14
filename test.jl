#variables and strings
name = "Asj"
num_fingers = 10
num_toes = 10
println("Hello, my name is $name.")
println("I have $num_fingers fingers and $num_toes toes. That is $(num_fingers + num_toes) digits in all!!")

string("How many cats ", "are too many cats?")
string("I don't know, but ", 10, " are too few.")

s3 = "How many cats ";
s4 = "are too many cats?"

s3*s4
"$s3$s4"

#dictionaries, tuples and arrays
myphonebook = Dict("Asj" => "0224742084", "Ghostbusters" => "555-2368")
myphonebook["Kramer"] = "555-FILK"

myphonebook

pop!(myphonebook, "Kramer")

myfavouriteanimals = ("penguins", "cats", "sugargliders")

myfavouriteanimals[1]

myfriends = ["Ted", "Robyn", "Barney", "lily", "Marshall"]
myfriends
myfriends[3]
myfriends[3] = "Baby Bop"

fibonacci = [1, 1, 2, 3, 5, 8]

mix = [1, 2, 3.0, "hi"]

push!(fibonacci, 13)
push!(fibonacci, 21)
pop!(fibonacci)

favourites = [["koobideh", "chocolate", "eggs"],["penguins", "cats", "sungliders"]]
numbers = [[1, 2, 3],[4, 5], [6, 7, 8, 9]]

rand(4,3)
rand(4, 3, 2)

#while and for loops

n = 0
while n < 10
    n += 1
    println(n)
end

i = 1
while i <= length(myfriends)
    friend = myfriends[i]
    println("Hi $friend, it's great to see you!")
    i += 1
end

for n in 1:10
    println(n)
end

for n = 1:10
    println(n)
end

for friend in myfriends
    println("Hi $friend, it's great to see you!")
end

m, n = 5,5
A = zeros(m,n)

for i in 1:m
    for j in 1:n
        A[i, j] = i + j
    end
end
A

for i in 1:m
    for j in 1:n
        A[i, j] = i * j
    end
end
A

B = zeros(m,n)
for i in 1:m, j in 1:n
    B[i, j] = i + j
end
B

C = [i + j for i in 1:m, j in 1:n]

for n in 1:10
    A = [i + j for i in 1:n, j in 1:n]
    display(A)
end

#conditionals, if, elseif, else, end
x = 16
y = 10

if x > y
    println("$x is larger than $y")
elseif y > x
    println("$y is larger than $x")
else
    println("$x and $y are equal")
end

if x > y
    x
else 
    y
end

# a ? b : c
#equivalent to: if a, b, else, c, end

(x>y) ? x : y

#a && b (executes if both a and b are true)
(x > y) && println("$x is larger than $y")
(x<y) && printlm("$x is smaller than $y")

#functions
function sayhi(name)
    println("Hi $name, it's great to see you")
end

function f(x)
    x^2
end

sayhi("C-3PO")
f(42)

sayhi2(name) = println("Hi $name, it's great to see you")
f2(x) = x^2
sayhi2("R2D2")
f2(42)

sayhi3 = name -> println("Hi $name, it's great to see you!")
f3 = x -> x^2

sayhi3("Chewbacca")
f3(42)

sayhi(55595472)

A = rand(3, 3)
f(A)

#mutating function - adding a bang (!) after a function alters the original input upon completion
v = [3, 5, 2]
sort(v)
sort!(v)
v

#broadcasting - add a period between a function name and its argument list to apply a function to the entries of an array rather than the array itself
A = [i + 3*j for j in 0:2, i in 1:3]
f(A)
f.(A)

#plotting
using Plots

x = -3:0.1:3
f(x) = x^2
y = f.(x)
gr()

plot(x,y, label="line")
scatter!(x,y, label="points")

plotlyjs()
plot(x,y, label="line")
scatter!(x,y, label="points")

globaltemperatures = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8]
numpirate = [45000, 20000, 15000, 5000, 400, 17]

plot(numpirate, globaltemperatures, legend=false)
scatter!(numpirate, globaltemperatures, legend = false)
xflip!()
xlabel!("Number of Pirates [approximate]")
ylabel!("Global temperature (C)")
title!("Influence of pirate population on global temperature")

p1 = plot(x,x)
p2 = plot(x, x.^2)
p3 = plot(x, x.^3)
p4 = plot(x, x.^4)
plot(p1,p2,p3,p4,layout=(2,2), legend=false)

methods(+)

#to determine which method of calculation
@which 3+3
@which 3.0+3.0
@which 3+3.0

import Base: +

#to add a new method of calculation
"hello " + "world!"
+(x::String, y::String) = string(x, y)

foo(x, y) = println("duck-typed foo!")
foo(x::Int, y::Float64) = println("foo with an integer and a gloat")
foo(x::Float64, y::Float64) = println("foo with two floats")
foo(x::Int, y::) = println("foo with two integers")

foo(1, 1)
foo(1.,1.)
foo(1,1.0)
foo(true, false)

#sums
a = rand(10^7)
sum(a)

#type \approx and then <TAB> to get approximately equal sign

A = rand(1:4,3,3,)
B = A
C = copy(A)
[ B C ]
A[1] = 17
[ B C ]
#B and A refer to the same place in memory while C is an entire new array that is identical to A

x= ones(3)
b = A*x
#A' is the conjugate transpose where A.' is just the transpose
Asym = A+A'
apd = A'A

# \ allows the problem Ax=b for square A to be solved
A\B

Atall = A[:,1:2]
display(Atall)
Atall\b

A = randn(3,3)
[A[:,1] A[:,1]]\b


Ashort = A[1:2,:]
display(Ashort)
Ashort\b[1:2]

#factorisations

using LinearAlgebra
A = randn(3,3)
factorize(A)
l,u,p = lu(A)

display(norm(l*u - A))
display(norm(l*u - A[p,:]))

Alu = lufact(A)

#stuck

Alu[:p]

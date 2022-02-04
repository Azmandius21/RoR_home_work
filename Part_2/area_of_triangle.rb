#take data about triangle from USER
puts "Enter base of triangle, please"
a = gets.chomp.to_i
puts "Enter height of triangle, please"
h = gets.chomp.to_i

# calculate area of triangle and display result
s = 0.5*a*h
puts "The area of triangle is #{s}"

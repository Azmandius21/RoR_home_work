#take data about triangle from USER
puts "Enter 1 sides of triangle, please"
x = gets.chomp.to_i
puts "Enter 2 sides of triangle, please"
y = gets.chomp.to_i
puts "Enter 3 sides of triangle, please"
z = gets.chomp.to_i

#calculate longest side of a triangle
tri = [x,y,z]
c = tri.max

#determine katets "a" and "b"
if tri.index(c)==0
  a,b = tri[1],tri[2]
elsif tri.index(c)==1
  a,b = tri[0],tri[2]
else  a,b = tri[0],tri[1]
end


#display result / calculate Phyfagorean formula and determine if a trianngle is a right triangle
puts "There is right triangle" if c == Math.sqrt(a**2+b**2)

#display results / determine  equilateraal and isosceles triangle
if a == b && a == c
  puts "There is equilateral triangle"
elsif a == b || b == c
  puts "There is isosceles triangle"
end

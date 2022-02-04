#Take coefficient a,b,c frome USER
puts "Enter coefficient a, please"
a = gets.chomp.to_i
puts "Enter coefficient b, please"
b = gets.chomp.to_i
puts "Enter coefficient c, please"
c = gets.chomp.to_i

#calculate dшscriminant
drm  = b**2 - 4*a*c

#calculate roots and display results

if drm < 0
  puts "Discriminante = #{drm}. There are no roots here"
else x1 = (-b + Math.sqrt(drm))/(2*a)
  x2 = (-b - Math.sqrt(drm))/(2*a)
  if x1 == x2
    puts "Discriminante = #{drm}. There are only 1 root: x = #{x1.floor(2)}"
  else puts "Discriminante = #{drm}. There are 2 roots: x1 = #{x1.floor(2)}, x2 = #{x2.floor(2)}"
  end
end

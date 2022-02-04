# Take data from user
puts "What is your name?"
name = gets.chomp
puts "Hi, #{name}!"
puts "What is your weight?"
weight = gets.chomp.to_i
puts "tall are you (example: 183 сm)?"
height = gets.chomp.to_i
#calculate and display Index of perfect weight
index = weight - (height-110)*1.15
puts  "#{name}, we calculate you weight index: #{index.round}"
puts "Your weight is optimal already!" if index < 0

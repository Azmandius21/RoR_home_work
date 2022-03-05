require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'modules'
require_relative 'railroad'
require_relative 'datagen'

loop do
  puts "Enter the name of the railroad or if you want to stop the program enter '0'"
  railroad = gets.chomp
  break if railroad.to_s == "0"
  eval('railroad = RailRoad.new')
  datagen(railroad)
  railroad.menu
end

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'modules'


class RailRoad
  attr_accessor :trains, :stations, :routes

  TYPES_TRAIN = /cargo|passenger/

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

=begin
  def seed
    self.stations = stations + [Station.new("Moscow") , Station.new("Kazan") , Station.new("Irkutsk"), Station.new("Ekaterinburg"),Station.new("Tumen")]
    self.trains = trains + [PassengerTrain.new(100),PassengerTrain.new(200), PassengerTrain.new(300), CargoTrain.new(500), CargoTrain.new(600), CargoTrain.new(700)]
  end
=end

  def menu
    puts "---------------------------------"
    puts "What do you want to do?
1 - create stations,trains,routes
2 - managing of the trains and routes
3 - take info about stations,trains,routes
0 - close this program
--------------------------------------------"
    case gets.chomp.to_i
    when 1 then create
    when 2 then manage
    when 3 then info
    when 0 then puts "program has been closed"
    else
      puts "You should select and put a number"
      menu
    end
  end

private #все последующие методы могут быть приватными, так как будут вызываться исключительно внутри класса через
          #управляющую программу "menu"

  def create
    puts "---------------------------------"
    puts "1 - create station
2 - create  train
3 - create route
0 - close this program
11 - go to main menu"
    puts "---------------------------------"
    case gets.chomp.to_i
    when 1 then create_station
    when 2
      begin
        create_train
      rescue RuntimeError => e
        puts e.message
        retry
      end
    when 3 then create_route
    when 0 then puts "program has been closed"
    when 11 then menu
    else
      puts "You should select and put a number"
      create
    end

  end

  def select_station
    puts "You should select the train"
    stations.each_with_index do |station, index|
      print index + 1
      print "-"
      puts station.name
    end
    index_of_station = gets.chomp.to_i-1
    return index_of_station
  end

  def select_train
    puts "You should select the train"
    trains.each_with_index do |train, index|
      print index + 1
      print "-"
      puts "#{train.number} | #{train.type}"
    end
    index_of_train = gets.chomp.to_i-1
    return index_of_train
  end

  def select_route
    puts "You should select the route"
    routes.each_with_index do |route, index|
      print index + 1
      print "-"
      puts "#{route.name}"
    end
    index_of_route = gets.chomp.to_i-1
    return index_of_route
  end

  def manage
    puts "---------------------------------"
    puts "What do you want to do with train?"
    puts "1 - assign a route to this train
2 - manage trains
3 - manage routes
0 - close this program
11 - back to main menu"
    puts "---------------------------------"
    case gets.chomp.to_i
    when 1
      assign_route_to_train
    when 2
      manage_trains
    when 3
      manage_routes
    when 11
      menu
    when 0
      puts "program has been closed"
    else
      puts "You should select and put a number"
    end
  end

  def assign_route_to_train
    trains[select_train].take_route(routes[select_route])
    manage
  end

  def manage_trains
    puts "---------------------------------"
    puts "1 - add wagon to the train
2 - remove wagon from the train
3 - move the train to the next station
4 - move the train to the previous station
11 - go to main menu
0 - close this program"
    puts "---------------------------------"
    case gets.chomp.to_i
    when 1 then add_wagon_to_train
    when 2 then remove_wagon_from_train
    when 3 then move_train_next_station
    when 4 then move_train_previous_station
    when 0 then puts "program has been closed"
    when 11 then menu
    else manage_trains
    end
  end

  def special_type_of_wagon
    puts "what type of wagon (passenger/cargo)?"
    case gets.chomp.to_sym
    when :passenger then PassengerWagon.new
    when :cargo then CargoWagon.new
    else "You should put a type of wagon"
    end
  end

  def add_wagon_to_train
    trains[select_train].add_wagon(special_type_of_wagon)
    manage_trains
  end

  def remove_wagon_from_train
    trains[select_train].remove_wagon
    manage_trains
  end

  def move_train_next_station
    trains[select_train].go_next_station
    manage_trains
  end

  def move_train_previous_station
    trains[select_train].go_previous_station
    manage_trains
  end

  def manage_routes
    puts "---------------------------------"
    puts "1 - add the stattion to the route
2 - remove the station from the route
11 - go to back
0 - close this program"
    puts "---------------------------------"
    case gets.chomp.to_i
    when 1 then add_station_to_route
    when 2 then remove_station_from_route
    when 0 then puts "program has been closed"
    when 11 then manage
    else manage_routes
    end
  end

  def add_station_to_route
    routes[select_route].add_station(stations[select_station])
    manage_routes
  end

  def remove_station_from_route
    routes[select_route].remove_station(stations[select_station])
    manage_routes
  end

  def info
    puts "---------------------------------"
    puts "1 - info station
2 - info  train
3 - info route
0 - close this program
11 - go to main menu"
    puts "---------------------------------"
    case gets.chomp.to_i
    when 1 then info_stations
    when 2 then info_trains
    when 3 then info_routes
    when 0 then puts "program has been closed"
    when 11 then menu
    else info
    end
  end

  def create_station
    puts "Enter name of the station:"
    name = gets.chomp
    @stations << Station.new(name)
    create
  end

  def create_train
  begin
    puts "Enter type of train (passenger/cargo):"
    type = gets.chomp.to_sym
    raise "Invaliid type of train" if type.to_s !~ TYPES_TRAIN
  rescue RuntimeError => e
    puts e.message
    retry
  end
    puts "Enter the number of train (xxx-xx or xxxxx):"
    number = gets.chomp
    case type
    when :passenger
      @trains << PassengerTrain.new(number)
    when :cargo
      @trains << CargoTrain.new(number)
    else
      puts "You didn't enter type of the train"
    end
    puts "#{type.to_s.capitalize()} train number #{number} created "
    create
  end

  def create_route
    puts "Select first station:"
    stations.each_with_index{|station, index| puts "#{index+1} - #{station.name}"}
    index_of_first_station = gets.chomp.to_i-1
    puts "Enter last station of this route:"
    stations.each_with_index{|station, index| puts "#{index+1} - #{station.name}"}
    index_last_station = gets.chomp.to_i-1
    @routes << Route.new(stations[index_of_first_station],stations[index_last_station])
    create
  end

  def info_stations
    puts "---------------------------------"
    stations.each do |station|
      puts "#{station.name} :"
      station.trains.each{ |train| puts "#{train.number}- #{train.type}" }
    end
    puts "---------------------------------"
    info
  end

  def info_trains
    puts "---------------------------------"
    trains.each do |train|
      puts "#{train.number} |#{train.current_station} | #{train.type} | #{train.wagons.size}- wagons"
    end
    puts "---------------------------------"
    info
  end

  def info_routes
    puts "---------------------------------"
    routes.each_with_index do |route, index|
      print "#{index+1}. "
      puts " #{route.stations.each{|station| print " #{station.name} "}}"
    end
    puts "---------------------------------"
    info
  end
end

rr = RailRoad.new
rr.menu

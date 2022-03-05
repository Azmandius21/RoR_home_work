class RailRoad
  attr_accessor :trains, :stations, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def menu
    puts "What do you want to do?
1 - create stations,trains,routes
2 - managing of the trains and routes
3 - take info about stations,trains,routes
0 - close this program"
    case gets.chomp.to_i
    when 1 then create
    when 2 then manage
    when 3 then info
    when 0 then puts "program has been closed"
    else
      menu
    end
  end

  private #все последующие методы могут быть приватными, так как будут вызываться исключительно внутри класса через
            #управляющую программу "menu"
  def create
    puts "1 - create station
2 - create  train
3 - create route
0 - close this program
11 - go to main menu"
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
    puts "What do you want to do with train/route?"
    puts "1 - assign a route to this train
2 - manage trains
3 - manage routes
0 - close this program
11 - back to main menu"
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
    end
  end

  def manage_wagons
    train = trains[select_train]
    train.block_wagons {|wagon, index| puts "#{index+1} - wagon "}
    puts "Select wagon"
    wagon_index =  gets.chomp.to_i
    if train.type == "passenger"
      train.wagons[wagon_index-1].take_seat_of
    else
      puts "How much volume needed to take?"
      volume = gets.chomp.to_i
      train.wagons[wagon_index-1].take_volume_of(volume)
    end
    manage_trains
  end

  def manage_passenger_wagon()

  end

  def assign_route_to_train
    trains[select_train].take_route(routes[select_route])
    manage
  end

  def manage_trains
    puts "1 - add wagon to the train
2 - remove wagon from the train
3 - move the train to the next station
4 - move the train to the previous station
5 - take seat/volume of train
11 - go to main menu
0 - close this program"
    case gets.chomp.to_i
    when 1 then add_wagon_to_train
    when 2 then remove_wagon_from_train
    when 3 then move_train_next_station
    when 4 then move_train_previous_station
    when 5 then manage_wagons
    when 0 then puts "program has been closed"
    when 11 then menu
    else
       manage_trains
    end
  end

  def special_type_of_wagon(type)
    case type
    when :passenger
      puts "Enter number of seats"
      seats_number = gets.chomp.to_i
      PassengerWagon.new(seats_number)
    when :cargo
      puts "Enter overall volume of wagon"
      overall_volume = gets.chomp.to_i
      CargoWagon.new(overall_volume)
    else
      puts "You should put a type of wagon"
    end
  end

  def add_wagon_to_train
    train = trains[select_train]
    train.add_wagon(special_type_of_wagon(train.type.to_sym))
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
    puts "1 - add the stattion to the route
2 - remove the station from the route
11 - go to back
0 - close this program"
    case gets.chomp.to_i
    when 1 then add_station_to_route
    when 2 then remove_station_from_route
    when 0 then puts "program has been closed"
    when 11 then manage
    else
      manage_routes
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
    puts "1 - info station
2 - info  train
3 - info route
4 - info about all path of railroad
0 - close this program
11 - go to main menu"
    case gets.chomp.to_i
    when 1 then info_stations
    when 2 then info_trains
    when 3 then info_routes
    when 4 then all_info
    when 0 then puts "program has been closed"
    when 11 then menu
    else
      info
    end
  end

  def create_station
    puts "Enter name of the station:"
    name = gets.chomp
    @stations << Station.new(name)
    create
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_train
    puts "Enter type of train (passenger/cargo):"
    type = gets.chomp
    puts "Enter the number of train (xxx-xx or xxxxx):"
    number = gets.chomp
    case type.to_sym
    when :passenger
      @trains << PassengerTrain.new(number, type)
    when :cargo
      @trains << CargoTrain.new(number, type)
    else raise "Invalid type of train"
    end
    puts "#{type.capitalize()} train number #{number} created "
    create
  rescue RuntimeError => e
    puts e.message
    retry
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
    stations.each do |station|
      puts "#{station.name} :"
      station.trains.each{ |train| puts "Train number: #{train.number} | train type: #{train.type} | wagons number: #{train.wagons.size}" }
    end
    info
  end

  def info_trains
    trains.each do |train|
      puts "Train number: #{train.number} | located in  #{train.current_station} | train type: #{train.type}"
      train.block_wagons do |wagon,index|
        puts "#{index+1} #{wagon.type_wagon} wagon: #{wagon.free_seats} - free seats #{wagon.occupied_seats} - occupied seats" if train.type == 'passenger'
        puts "#{index+1} #{wagon.type_wagon} wagon: #{wagon.free_volume} - free volume. #{wagon.occupied_volume} - occupied volume" if train.type == 'cargo'
      end
    end
    info
  end

  def info_routes
    routes.each_with_index do |route, index|
      print "#{index+1}. "
      puts " #{route.stations.each{|station| print " #{station.name} "}}"
    end
    info
  end

  def all_info
    stations.each do |station|
      puts station.name
      station.block_trains do |train|
        puts "Train number #{train.number} #{train.type} type with  #{train.wagons.size} wagons :"
        train.block_wagons do |wagon,index|
          puts "#{index + 1} wagon #{train.type}"
          case train.type
          when "passenger"
            puts "Free seats : #{wagon.free_seats}. Occupied seats : #{wagon.occupied_seats}"
          when "cargo"
            puts "Free volume : #{wagon.free_volume}. Occupied volume : #{wagon.occupied_volume}"
          end
        end
      end
    end
  end
end

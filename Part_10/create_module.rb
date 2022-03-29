# frozen_string_literal: true

# Creating methods for RailRoad instancec
module Create
  def create
    menu_create_text
    options = { '0' => 'escape',
                '1' => 'create_station',
                '2' => 'create_train',
                '3' => 'create_route',
                '11' => 'menu' }
    doing = options[gets.chomp.to_s] || 'create'
    send(doing)
    # case gets.chomp.to_i
    # when 1 then create_station
    # when 2
    #   begin
    #     create_train
    #   rescue RuntimeError => e
    #     puts e.message
    #     retry
    #   end
    # when 3 then create_route
    # when 0 then puts 'program has been closed'
    # when 11 then menu
    # else
    #   create
    # end
  end

  def create_station
    puts 'Enter name of the station:'
    name = gets.chomp
    @stations << Station.new(name)
    create
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_train
    puts 'Enter type of train (passenger/cargo):'
    type = gets.chomp.to_sym
    puts 'Enter the number of train (xxx-xx or xxxxx):'
    number = gets.chomp
    shed(number, type)
    create
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def shed(number, type)
    shed = { passenger: PassengerTrain.new(number, type), cargo: CargoTrain.new(number, type) }
    @trains << shed[type]
    puts "#{type.capitalize} train number #{number} created "
  end

  def create_route
    puts 'First station:'
    index_first_station = select_station
    puts 'Enter last station of this route:'
    index_last_station = select_station
    create_route_instance(index_first_station, index_last_station)
  end

  def create_route_instance(index_first_station, index_last_station)
    @routes <<
      Route.new(index_first_station, index_last_station)
    create
  end

  def create_wagon(type)
    puts 'Enter total place / number of seats'
    total_place = gets.chomp.to_i
    shed_wagon(type, total_place)
  end

  def shed_wagon(type, total_place)
    options = { passenger: PassengerWagon.new(total_place),
                cargo: CargoWagon.new(total_place) }
    options[type.to_sym]
  end
end

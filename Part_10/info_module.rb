# frozen_string_literal: true

# Module with creators methods for RailRoad instances
module Info
  def info_stations
    stations.each do |station|
      puts "#{station.name} :"
      station.trains.each do |train|
        puts "Train number: #{train.number}\
        train type: #{train.type} | wagons number: #{train.wagons.size}"
      end
    end
    info
  end

  def info_trains
    options = { passenger: 'info_passenger_train',
                cargo: 'info_cargo_train' }
    trains.each do |train|
      puts "Train number: #{train.number} | located in \
      #{train.current_station} | train type: #{train.type}"
      train.block_wagons do |wagon, index|
        send(options[train.type.to_sym], wagon, index)
      end
    end
    info
  end

  def info_passenger_train(wagon, index)
    puts "  #{index + 1} #{wagon.type_wagon.ljust(10)} wagon:\
    Free seats #{wagon.free_place} | Occupied seats #{wagon.used_place}"
  end

  def info_cargo_train(wagon, index)
    puts "  #{index + 1} #{wagon.type_wagon.ljust(10)} wagon:\
    Free volume #{wagon.free_place} | Occupied volume #{wagon.used_place}"
  end

  def info_routes
    routes.each_with_index { |route, i| puts "#{i + 1} - #{route.name}" }
    info
  end
end

# frozen_string_literal: true

STATIONS =
  %w[Ekaterinburg Tumen Kazan Moskow Vladovostok
     Tver Voronej N.Novgorog St.Petersburg].freeze

def datagen(railroad)
  gen_stations(railroad)
  gen_routes(railroad)
  gen_trains(railroad)
  gen_wagons(railroad)
  railroad.trains[0].take_route(railroad.routes[0])
  railroad.trains[1].take_route(railroad.routes[1])
end

def gen_stations(railroad)
  5.times do |index|
    railroad.stations << Station.new(STATIONS[index])
  end
end

def gen_routes(railroad)
  2.times do |index|
    railroad.routes << Route.new(railroad.stations[index],
                                 railroad.stations[-index - 1])
  end
end

def gen_trains(railroad)
  2.times do |index|
    railroad.trains << CargoTrain.new(format('car-0%d', index + 1), 'cargo')
    railroad.trains << PassengerTrain.new(format('pas-0%d', index + 1), 'passenger')
  end
end

def gen_wagons(railroad)
  5.times { railroad.trains[1].add_wagon(PassengerWagon.new(40)) }
  5.times { railroad.trains[0].add_wagon(CargoWagon.new(500)) }
end

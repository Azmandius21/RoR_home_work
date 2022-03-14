STATIONS =
  ['Ekaterinburg', 'Tumen', 'Kazan', 'Moskow', 'Vladovostok',
   'Tver', 'Voronej', 'N.Novgorog', 'St.Petersburg']

def datagen(railroad)
  5.times do |index|
    railroad.stations << Station.new(STATIONS[index])
  end
  2.times do |index|
    railroad.routes << Route.new(railroad.stations[index],
                                 railroad.stations[index + 1])
  end
  2.times do |index|
    railroad.trains << CargoTrain.new(format('car-0%d', index), 'cargo')
    railroad.trains << PassengerTrain.new(format('pas-0%d', index), 'passenger')
  end
  5.times { railroad.trains[0].add_wagon(CargoWagon.new(1000)) }
  5.times { railroad.trains[1].add_wagon(PassengerWagon.new(40)) }
  railroad.trains[0].take_route(railroad.routes[0])
  railroad.trains[1].take_route(railroad.routes[1])
end

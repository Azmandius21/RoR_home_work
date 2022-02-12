class Train #Методы данного класса должны быть публичны, ,так как будут вызываться не в родственных классах
  attr_accessor :speed, :station, :wagons, :current_station_index
  attr_reader :number, :route
  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @route = route
    @current_station_index = nil
  end

  def name
    puts "#{number} | type:#{type_of_train} | wagons :#{wagons.size}"
  end

  def add_wagon(wagon)
    self.wagons << wagon if correct_type_wagon?(wagon)
  end

  def remove_wagon
    wagons.delete_at(-1) until wagons.empty?
  end

  def stop
    self.speed = 0
  end


  def take_route(route)
    @route = route
    self.current_station_index = 0
    route.stations[current_station_index].add_train(self)
  end

  def current_station
    route.stations[current_station_index].name unless current_station_index.nil?
  end

  def next_station
    route.stations[current_station_index+1] if route.stations[current_station_index]!=route.stations.last
  end

  def previouss_station
    route.stations[current_station_index-1] if route.stations[current_station_index]!=route.stations.first
  end

  def go_next_station
    self.current_station_index += 1 if route.stations[current_station_index]!=route.stations.last
    puts "Train at the station #{current_station} "
  end

  def go_previous_station
    self.current_station_index -= 1 if route.stations[current_station_index]!=route.stations.first
    puts "Train at the station #{current_station} "
  end
end

class Station
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  # Receive the train in to the station
  def add_train(train)
    if trains.include?(train)
      "Sorry, but the train is already on #{self}"
    else
      trains.push(train)
    end
  end

  #Display  list of trains on the station and sort it by types
  def trains_list_by_type(type)
    trains.select{|train| train.type ==type}.count
  end

  # Let out the train
  def train_dispatch(train)
    trains.delete(train)
    puts "Train #{train} number #{train.number} has been dispatch"
  end
end

class Route
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @route_list = []
  end

  #It puts the station befor last station of the route
  def add_station(station)
    @stations.insert(-2) << station
  end

  #It deletes the station from the route
  def remmove_station(stantion)
    @stations.delete(station)
  end
end

class Train
  # self.wagons - return number of wagons
  attr_accessor :speed, :station, :wagons
  attr_reader :type, :number, :route

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  # Delete/Add 1 wagon
  def change_wagons(action)
    return "Train must be stoped to add or remove wagons" if self.speed == 0
    case action
    when :add
      self.wagons += 1
    when :remove
      self.wagons -= 1 if wagons > 1
    end
  end

  # The train takes the route
  def take(route)
    @route = route
    @current_station_index = 0
    route.add_train(self)
  end

  # Showing current, next, previous station
  def current_station
    route.stations[current_station_index]
  end

  def next_station
    route.stations[current_station_index+1] if route.stations[current_station_index]==route.stations[last]
  end

  def previouss_station
    route.stations[current_station_index-1] if route.stations[current_station_index]==route.stations[first]
  end

  #Changing current station of train by next on the route
  def go_next_station
    @current_station_index += 1 if route.stations[current_station_index]==route.stations[last]
  end

  #Changing current station of train by previous on the route
  def go_previous_station
    @current_station_index -= 1 if route.stations[current_station_index]==route.stations[first]
  end
end

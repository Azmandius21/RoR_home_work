class Route #Методы данного класса должны быть публичны, ,так как будут вызываться не в родственных классах
  include InstanceCounter
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @route_list = []
    register_instance
  end

  def name
    print "From #{@stations[0].name} to #{@stations[-1].name}"
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station) unless station == stations[0] unless station == stations[-1]
  end
end

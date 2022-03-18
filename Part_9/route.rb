# frozen_string_literal: true

# Методы данного класса должны быть публичны, ,так как будут вызываться не в родственных классах
class Route
  include Validate
  include InstanceCounter
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    @route_list = []
    register_instance
  end

  def name
    "From #{@stations.first.name} to #{@stations.last.name}"
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station) if station != stations[-1] && station != stations[0]
  end

  private

  def validate!
    raise 'The route must have 2 stations' if stations.size < 2
  end
end

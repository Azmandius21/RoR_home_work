# frozen_string_literal: true
require_relative 'validate_module'
require_relative 'accessor_module'
# Методы данного класса должны быть публичны, ,так как будут вызываться не в родственных классах
class Route
  include Validations
  include InstanceCounter
  include Accessor

  attr_reader :stations

  strong_attr_accessor :@stations, Array

  validate :stations, :size_validation, 2

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
end

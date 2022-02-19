require_relative 'modules'

class Train
  include CompanyName, InstanceCounter, Validate
  attr_accessor :speed, :station, :wagons, :current_station_index
  attr_reader :number, :route

  TRAIN_NUMBER = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i
  @@instances = []

  def self.find(number)
    @@instances.detect {|train| train.number == number}
  end

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @route = route
    @current_station_index = nil
    @@instances << self
    validate!
    register_instance
  end

  def train_number
    puts "#{number} | type:#{type} | wagons :#{wagons.size}"
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
  end

  def go_previous_station
    self.current_station_index -= 1 if route.stations[current_station_index]!=route.stations.first
  end

  private

  def validate!
    raise "The number of train can't be nil" if number.nil?
    raise "Invalid number format" if number !~ TRAIN_NUMBER
  end
end

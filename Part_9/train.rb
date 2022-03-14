require_relative 'modules'

class Train
  include Validate
  include InstanceCounter
  include CompanyName
  attr_accessor :speed, :station, :wagons, :current_station_index
  attr_reader :number, :route, :type

  TRAIN_NUMBER = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i
  TYPES_TRAIN = /cargo|passenger/

  @@instances = []

  def self.find(number)
    @@instances.detect { |train| train.number == number }
  end

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    @speed = 0
    @wagons = []
    @route = route
    @current_station_index = nil
    @@instances << self
    register_instance
  end

  def block_wagons(&block)
    wagons.each_with_index(&block)
  end

  def train_number
    puts "#{number} | type:#{type} | wagons :#{wagons.size}"
  end

  def add_wagon(wagon)
    wagons << wagon if correct_type_wagon?(wagon)
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
    route.stations[current_station_index + 1] if route.stations[current_station_index] != route.stations.last
  end

  def previouss_station
    route.stations[current_station_index - 1] if route.stations[current_station_index] != route.stations.first
  end

  def go_next_station
    self.current_station_index += 1 if route.stations[current_station_index] != route.stations.last
  end

  def go_previous_station
    self.current_station_index -= 1 if route.stations[current_station_index] != route.stations.first
  end

  protected

  def validate!
    errors = []
    errors << "The number of train can't be nil" if number.nil?
    errors << 'Invalid number format' if number !~ TRAIN_NUMBER
    errors << 'Invalid type of train' if type !~ TYPES_TRAIN
    raise errors.join(',') unless errors.empty?
  end
end

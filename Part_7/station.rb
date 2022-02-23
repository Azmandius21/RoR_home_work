require_relative 'modules.rb'
class Station #Методы данного класса должны быть публичны,
              #так как будут вызываться не в родственных классах
  include InstanceCounter, Validate
  attr_accessor :trains
  attr_reader :name

  STATION_NAME = /^[A-ZА-Я]\w+/

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    validate!
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def add_train(train)
    if trains.include?(train)
    else
      trains.push(train)
    end
  end

  def trains_list_by_type(type)
    trains.select{|train| train.type ==type}.count
  end

  def train_dispatch(train)
    trains.delete(train)
  end

  private

  def validate!
    raise "Station station can't be nil" if name.nil?
    raise "Invalid station name" if name !~ STATION_NAME
  end
end

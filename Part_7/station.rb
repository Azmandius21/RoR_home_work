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
    @name = name
    validate!
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
    errors = []
    errors << "Station station can't be nil" if name.nil?
    errors << "Invalid station name" if name !~ STATION_NAME
    errors << "Invalid number of characters , less then 2" if name.length < 2
    errors << "First letter must be capitalize" if name !~ /^[A-ZА-Я]/
    raise errors.join("\n") unless errors.empty?
  end
end

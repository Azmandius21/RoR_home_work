# frozen_string_literal: true

# Методы данного класса должны быть публичны,
# так как будут вызываться не в родственных классах

require_relative 'modules'

class Station
  include Validate
  include InstanceCounter
  attr_accessor :trains
  attr_reader :name

  STATION_NAME = /^[A-ZА-Я]\w+/.freeze

  @@instances = []

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@instances << self
    register_instance
  end

  def block_trains(&block)
    trains.each(&block)
  end

  def add_train(train)
    trains.push(train) unless trains.include?(train)
  end

  def trains_list_by_type(type)
    trains.select { |train| train.type == type }.count
  end

  def train_dispatch(train)
    trains.delete(train)
  end

  private

  def validate!
    errors = []
    errors << "Station station can't be nil" if name.nil?
    errors << 'Invalid station name' if name !~ STATION_NAME
    errors << 'Invalid number of characters , less then 2' if name.length < 2
    errors << 'First letter must be capitalize' if name !~ /^[A-ZА-Я]/
    raise errors.join("\n") unless errors.empty?
  end
end

# frozen_string_literal: true

require_relative 'text'
require_relative 'create_module'
require_relative 'info_module'
require_relative 'select_module'

class RailRoad
  include Text
  include Create
  include Info
  include Select

  attr_accessor :trains, :stations, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def escape
    puts 'The program has been close'
  end

  def menu
    options = { '1' => 'create',
                '2' => 'manage',
                '3' => 'info',
                '0' => 'escape' }
    menu_text
    doing = options[gets.chomp.to_s] || 'menu'
    send(doing)
  end

  private

  def manage
    options = { '0' => 'escape',
                '1' => 'assign_route_to_train',
                '2' => 'manage_trains',
                '3' => 'manage_routes',
                '11' => 'menu' }
    manage_text
    doing = options[gets.chomp.to_s] || 'manage'
    send(doing)
  end

  def manage_trains
    options = { '0' => 'escape',
                '1' => 'add_wagon_to_train',
                '2' => 'remove_wagon_from_train',
                '3' => 'move_train_next_station',
                '4' => 'move_train_previous_station',
                '5' => 'manage_wagons',
                '11' => 'manage' }
    manage_train_text
    doing = options[gets.chomp.to_s] || 'manage_trains'
    send(doing)
  end

  def info
    options = { '0' => 'escape',
                '1' => 'info_stations',
                '2' => 'info_trains',
                '3' => 'info_routes',
                '11' => 'menu' }
    info_text
    doing = options[gets.chomp.to_s] || 'info'
    send(doing)
  end

  def manage_routes
    options = { '0' => 'escape',
                '1' => 'add_station_to_route',
                '2' => 'remove_station_from_route',
                '11' => 'manage' }
    manage_routes_text
    doing = options[gets.chomp.to_s] || 'manage_routes'
    send(doing)
  end

  def manage_wagons
    train = trains[select_train]
    wagon_index = select_wagon(train)
    if train.type == 'passenger'
      train.wagons[wagon_index].take_seat_of
    else
      train.wagons[wagon_index].take_volume_of
    end
    manage_trains
  end

  def assign_route_to_train
    trains[select_train].take_route(routes[select_route])
    manage
  end

  def add_wagon_to_train
    train = trains[select_train]
    train.add_wagon(create_wagon(train.type.to_sym))
    manage_trains
  end

  def remove_wagon_from_train
    trains[select_train].remove_wagon
    manage_trains
  end

  def move_train_next_station
    trains[select_train].go_next_station
    manage_trains
  end

  def move_train_previous_station
    trains[select_train].go_previous_station
    manage_trains
  end

  def add_station_to_route
    routes[select_route].add_station(stations[select_station])
    manage_routes
  end

  def remove_station_from_route
    routes[select_route].remove_station(stations[select_station])
    manage_routes
  end
end

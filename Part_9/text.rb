# frozen_string_literal: true

module Text
  def menu_text
    puts "
    What do you want to do?
    1 - create stations,trains,routes
    2 - managing of the trains and routes
    3 - take info about stations,trains,routes
    0 - close this program"
  end

  def menu_create_text
    puts "
     1 - create station
     2 - create  train
     3 - create route
    11 - go to main menu
     0 - close this program"
  end

  def manage_text
    puts "
    What do you want to do with train/route?
    1 - assign a route to this train
    2 - manage trains
    3 - manage routes
   11 - back to main menu
    0 - close this program"
  end

  def manage_train_text
    puts "
     1 - add wagon to the train
     2 - remove wagon from the train
     3 - move the train to the next station
     4 - move the train to the previous station
     5 - take seat/volume of train
    11 - go to main menu
     0 - close this program"
  end

  def manage_routes_text
    puts "
     1 - add the stattion to the route
     2 - remove the station from the route
    11 - go to back
     0 - close this program"
  end

  def info_text
    puts "
     1 - info station
     2 - info  train
     3 - info route
    11 - go to main menu
     0 - close this program"
  end
end

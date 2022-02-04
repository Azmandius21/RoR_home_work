class Station

  attr_accessor :trains
  attr_reader :name
  def initialize(name)
    @name = name
    self.trains = []
  end
# Receive the train in to the station
  def add_train(train)
    if self.trains.include?(train)
      "Sorry, but the train is already on #{self}"
    else self.trains.push(train)
    end
  end
#Display  list of trains on the station and sort it by types
  def trains_list_by_type
    puts "Passenger trains :"
    self.trains.each{|train| if train.type == "pas"
      puts train.number
      end}
    puts "Freight trains:"
    self.trains.each{|train| if train.type == "freight"
      puts train.number
      end}
  end
# Let out the train
  def train_dispatch(train)
    self.trains = self.trains - [train]
    puts "Train #{train} number #{train.number} has been dispatch"
  end

end

class Route

  def initialize(first,last)
    @first = first
    @intermediate = []
    @last = last
    @route_list = []
  end
#It puts the station between begin and end of the route
  def intermediate=(station)
    @intermediate << station
    self.route_list
  end
#It deletes the station from the route
  def delete_intermediate(stantion)
    @intermediate -= [stantion]
    self.route_list
  end
  def route_list
    @route_list = [@first] + @intermediate + [@last]
  end
  def show_route
    self.route_list.each{|station| puts station.name}
  end

end

class Train
# self.wagons - return number of wagons
  attr_accessor :speed, :station, :wagons
  attr_reader :type, :number, :my_route


  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @my_route = []
    @speed = 0
  end

  def stop
    self.speed = 0
  end
# Delete/Add 1 wagon
  def add_delete_wagons
    if self.speed == 0
      puts "if you want hitch wagon -  put 1, if unhook wagon - put 2"
      action = gets.chomp.to_i
      case action
      when 1
        if self.wagons < 777
          self.wagons += 1
        end
      when 2
        if self.wagons > 1
          self.wagons -= 1
        end
      else "You must write 1 or 2"
      end
    else puts "Train must be stoped for this action"
    end
  end

# The train takes the route
  def take(route)
    @my_route = route.route_list
    @station = route.route_list[0]
    route.route_list[0].add_train(self)
  end
# Showing current, next, previous station
  def current_station
    @station.name
  end

  def next_station
    if self.station == self.my_route[-1]
      puts "Current station is the last in the route"
    else index = @my_route.index(@station)
      puts @my_route[index+1].name
    end
  end

  def previous_station
    if self.station == self.my_route[0]
      puts "The train is at the beginning of the route"
    else index = @my_route.index(@station)
      puts @my_route[index-1].name
    end
  end

#Changing current station of train by next on the route
  def go_next_station
    if self.station == self.my_route[-1]
      puts "The journey is over"
    else index = @my_route.index(@station)
      @station = @my_route[index+1]
      self.my_route[index].train_dispatch(self)
      self.my_route[index+1].add_train(self)
    end
  end
#Changing current station of train by previous on the route
  def go_previous_station
    if self.station == self.my_route[0]
      puts "The train is at the beginning of the route"
    else index = @my_route.index(@station)
      @station = @my_route[index-1]
      self.my_route[index].train_dispatch(self)
      self.my_route[index-1].add_train(self)
    end
  end

end

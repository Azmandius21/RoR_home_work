class Station #Методы данного класса должны быть публичны, ,так как будут вызываться не в родственных классах
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    if trains.include?(train)
      "Sorry, but the train is already on #{self}"
    else
      trains.push(train)
    end
  end

  def trains_list_by_type(type)
    trains.select{|train| train.type ==type}.count
  end

  def train_dispatch(train)
    trains.delete(train)
    puts "Train #{train} number #{train.number} has been dispatch"
  end
end

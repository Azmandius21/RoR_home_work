# frozen_string_literal: true

module Select
  protected

  def select_station
    puts 'You should select the station'
    stations.each_with_index { |st, i| puts "#{i + 1} - #{st.name}" }
    gets.chomp.to_i - 1
  end

  def select_train
    puts 'You should select the train'
    trains.each_with_index do |tn, i|
      puts "#{i + 1} #{tn.number.ljust(5)} | #{tn.type.ljust(10)}"
    end
    gets.chomp.to_i - 1
  end

  def select_wagon(train)
    train.block_wagons { |_wagon, index| puts "#{index + 1} - wagon " }
    puts 'Select wagon'
    gets.chomp.to_i - 1
  end

  def select_route
    puts 'You should select the route'
    routes.each_with_index { |route, i| puts "#{i + 1} - #{route.name}" }
    gets.chomp.to_i - 1
  end
end

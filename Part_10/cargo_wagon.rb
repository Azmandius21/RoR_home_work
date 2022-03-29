# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(total_place)
    super
    @type_wagon = 'cargo'
  end

  def take_volume_of
    puts 'How much volume needed to take?'
    volume = gets.chomp.to_i
    self.used_place += volume if free_place >= volume
  end
end

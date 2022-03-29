# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize(total_place)
    super
    @type_wagon = 'passenger'
  end

  def take_seat_of
    self.used_place += 1 if total_place > used_place
  end
end

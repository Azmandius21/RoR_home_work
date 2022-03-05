class PassengerWagon
  include CompanyName

  attr_accessor
  attr_reader :seats_number, :free_seats, :type_wagon

  def initialize(seats_number)
    @seats_number = seats_number
    @free_seats = @seats_number
    @type_wagon = 'passenger'
  end

  def take_seat_of
    self.free_seats -= 1 if free_seats > 0
  end

  def occupied_seats
    seats_number - free_seats
  end

  private

  attr_writer :free_seats
end

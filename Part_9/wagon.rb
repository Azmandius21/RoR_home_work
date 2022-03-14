class Wagon
  include CompanyName

  attr_reader :total_place, :used_place, :type_wagon

  def initialize(total_place)
    @total_place = total_place
    @used_place = 0
  end

  def free_place
    total_place - used_place
  end

  protected

  attr_writer :used_place
end

class CargoWagon < Wagon
  def initialize(total_place)
    super
    @type_wagon = 'cargo'
  end

  def take_volume_of(volume)
    self.used_place += volume if free_place >= volume
  end
end

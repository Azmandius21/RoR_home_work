class CargoWagon
  include CompanyName

  attr_reader :overall_volume, :free_volume, :type_wagon

  def initialize(overall_volume)
    @overall_volume = overall_volume
    @free_volume = @overall_volume
    @type_wagon = 'cargo'
  end

  def take_volume_of(volume)
    self.free_volume -= volume if free_volume >= volume
  end

  def occupied_volume
    overall_volume - free_volume
  end

  private

  attr_writer :free_volume
end

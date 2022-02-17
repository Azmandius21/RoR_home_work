class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = "cargo"
  end


  protected

  def correct_type_wagon?(wagon) #Метод вызывается только родительским классом Train
    wagon.class == CargoWagon
  end
end

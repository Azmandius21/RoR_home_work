class CargoTrain < Train
  attr_reader :type_of_train

  def initialize(number)
    super
    @type_of_train = "cargo"
  end


  protected

  def correct_type_wagon?(wagon) #Метод вызывается только родительским классом Train
    wagon.class == CargoWagon
  end
end

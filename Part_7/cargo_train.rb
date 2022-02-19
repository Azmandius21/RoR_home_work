class CargoTrain < Train
  attr_reader :type

  TRAIN_NUMBER = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  def initialize(number)
    super
    @type = "cargo"
    validate!
  end

  protected

  def validate!
    raise "Invalid number format" if number !~ TRAIN_NUMBER
  end

  def correct_type_wagon?(wagon) #Метод вызывается только родительским классом Train
    wagon.class == CargoWagon
  end
end

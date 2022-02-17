class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = "passenger"
  end


  protected

  def correct_type_wagon?(wagon) #Метод вызывается только родительским классом Train
    wagon.class == PassengerWagon
  end
end

class PassengerTrain < Train
  attr_reader :type_of_train

  def initialize(number)
    super
    @type_of_train = "passenger"
  end


  protected

  def correct_type_wagon?(wagon) #Метод вызывается только родительским классом Train
    wagon.class == PassengerWagon
  end
end

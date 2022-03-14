class PassengerTrain < Train
  protected

  def correct_type_wagon?(wagon) # Метод вызывается только родительским классом Train
    wagon.instance_of?(PassengerWagon)
  end
end

class PassengerTrain < Train
  protected

  # Метод вызывается только родительским классом Train
  def correct_type_wagon?(wagon)
    wagon.instance_of?(PassengerWagon)
  end
end

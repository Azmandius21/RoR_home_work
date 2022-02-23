class PassengerTrain < Train
  protected

  def correct_type_wagon?(wagon) #Метод вызывается только родительским классом Train
    wagon.class == PassengerWagon
  end
end

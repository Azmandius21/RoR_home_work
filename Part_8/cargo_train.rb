class CargoTrain < Train
  protected

  def correct_type_wagon?(wagon) #Метод вызывается только родительским классом Train
    wagon.class == CargoWagon
  end
end

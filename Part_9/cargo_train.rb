class CargoTrain < Train
  protected

  # Метод вызывается только родительским классом Train
  def correct_type_wagon?(wagon)
    wagon.class.instance_of? CargoWagon
  end
end

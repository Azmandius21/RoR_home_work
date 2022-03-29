# frozen_string_literal: true

class CargoTrain < Train
  protected

  # Метод вызывается только родительским классом Train
  def correct_type_wagon?(wagon)
    wagon.instance_of?(CargoWagon)
  end
end

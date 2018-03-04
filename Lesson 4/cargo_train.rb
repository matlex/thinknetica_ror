require_relative 'train'
require_relative 'cargo_wagon'

class CargoTrain < Train
  # Проверку типа вагона выносим в private т.к. будет проверяться только внутри класса.
  private

  CORRECT_WAGON_TYPE = CargoWagon

  def correct_type?(wagon)
    wagon.is_a?(CORRECT_WAGON_TYPE)
  end
end

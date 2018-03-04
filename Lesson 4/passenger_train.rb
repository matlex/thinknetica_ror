class PassengerTrain < Train
  # Проверку типа вагона выносим в private т.к. будет проверяться только внутри класса.
  private

  CORRECT_WAGON_TYPE = PassengerWagon

  def correct_type?(wagon)
    wagon.is_a?(CORRECT_WAGON_TYPE)
  end
end

require_relative 'train'
require_relative 'passenger_wagon'

class PassengerTrain < Train
  private

  CORRECT_WAGON_TYPE = PassengerWagon
  def correct_wagon_type
    CORRECT_WAGON_TYPE
  end
end

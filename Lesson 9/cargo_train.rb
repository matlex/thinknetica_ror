require_relative 'train'

class CargoTrain < Train
  TRAIN_TYPE = 'Cargo'.freeze

  def initialize(number)
    super(number, TRAIN_TYPE)
  end

  private

  def correct_train_type
    TRAIN_TYPE
  end

end

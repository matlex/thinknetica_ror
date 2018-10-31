module StrangeCar
  def fly
    puts "Now a #{self.class.name} can fly :)"
  end
end

class Vehicle
  attr_accessor :speed, :color
  attr_reader :year

  # Track a number of classes created
  @@number_of_cars = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0

    @@number_of_cars += 1
  end

  def age
    puts "The age of #{self.class.name} is #{get_car_age}"
  end

  def speed_up
    self.speed += 10
  end

  def brake
    self.speed -= 10
  end

  def shut_off
    self.speed = 0
  end

  def current_speed
    puts self.speed
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def self.gas_mileage(litres, km)
    # Class method
    puts "#{km / litres} kilometers per liter of gasoline"
  end

  def self.number_of_cars
    puts "We have #{@@number_of_cars} cars created at the moment!"
  end

  private

  def get_car_age
    Time.now.year - self.year
  end

end

class MyTruck < Vehicle
  MAX_SPEED_KM = 120

  def to_s
    "My car is: #{@model}, a year is #{@year} and color is #{@color}"
  end
end

class MyCar < Vehicle
  BATTERY_ONE_CHARGE_TRIP_KM = 400
  MAX_SPEED_KM = 220

  def to_s
    "My truck is: #{@model}, a year is #{@year} and color is #{@color}"
  end
end

class FlyCar < Vehicle
  include StrangeCar
end

rx330 = MyCar.new(2005, 'white', 'Lexus')
iveco_truck = MyTruck.new('2008', 'silver', 'Mercedes')

rx330.current_speed
rx330.speed_up
rx330.speed_up
rx330.current_speed
rx330.shut_off
rx330.current_speed
puts rx330.year
rx330.spray_paint 'black'
puts rx330.color
rx330

Vehicle.gas_mileage(60, 400)
puts rx330
puts iveco_truck

Vehicle.number_of_cars

flycar = FlyCar.new('2050', 'Silver', 'ZZZ')
flycar.fly
puts
puts MyTruck.ancestors
puts
puts MyCar.ancestors
puts
puts FlyCar.ancestors
puts
puts Vehicle.ancestors
puts

rx330.age







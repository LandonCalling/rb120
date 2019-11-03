require 'time'

class Vehicle
  attr_accessor :color, :speed
  attr_reader :year, :model
  @@num_child_objects = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@num_child_objects += 1
  end

  def self.number_of_vehicles
    puts "There are #{@@num_child_objects} vehicle objects created."
  end

  def age
    "The age of the #{model} is #{years_old}."
  end

  def accelerate(speed_up)
    self.speed += speed_up
    puts "You push the gas and accelerate #{speed_up} mph."
  end

  def brake(speed_down)
    self.speed -= speed_down
    puts "You push the brake and decelerate #{speed_down} mph."
  end

  def current_speed
    puts "You are now going #{self.speed} mph."
  end

  def turn_off
    self.speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(paint_color)
    self.color = paint_color
    puts "Your new #{paint_color} paint job looks great!"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

module Towable
  def can_tow?(pounds)
    pounds < 1500 ? true : false
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  def to_s
    "This car is a #{year} #{model}, and its color is #{color}."
  end
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2
  attr_reader :bed_size

  def initialize(year, color, model, bed_size)
    super(year, color, model)
    @bed_size = bed_size
  end

  def to_s
    "This truck is a #{year} #{model}, and its color is #{color}."
  end
end

puts '---MyCar Ancestor List---'
puts MyCar.ancestors
puts '---MyTruck Ancestor List---'
puts MyTruck.ancestors

accord = MyCar.new(2019, 'red', 'Honda Accord')
accord.accelerate(60)
accord.brake(20)
accord.current_speed
accord.spray_paint('black')
MyCar.gas_mileage(17, 600)
MyCar.number_of_vehicles
puts accord.age

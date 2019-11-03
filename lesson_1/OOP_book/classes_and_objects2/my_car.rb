class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
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

  def to_s
    "This car is a #{year} #{model}, and its color is #{color}."
  end
end

accord = MyCar.new(2019, 'red', 'Honda Accord')
puts accord
MyCar.gas_mileage(17, 450)

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
end

accord = MyCar.new(2019, 'red', 'Honda Accord')
puts accord.color
puts accord.year
accord.spray_paint('black')
puts accord.color
accord.accelerate(20)
accord.current_speed
accord.accelerate(20)
accord.current_speed
accord.brake(20)
accord.current_speed
accord.brake(20)
accord.current_speed
accord.turn_off
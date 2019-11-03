class GoodDog
  attr_accessor :name, :height, :weight

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def initialize(name, height, weight)
    @name = name
    @height = height
    @weight = weight
  end

  def speak
    "#{name} says arf!"
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info

sparky.change_info('Sparticus', '24 inches', '45 lbs')
puts sparky.info

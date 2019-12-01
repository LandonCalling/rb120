class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end

# the attr_accessor for brightness and color isn't needed because
# we don't use any getter or setter methods for those variables
# also the retun is unnecessary because Ruby implicitly returns
# the last statement in a method.
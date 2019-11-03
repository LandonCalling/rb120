class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  def public_disclosure
    "#{name} in human years is #{human_years}."
  end

  def a_public_method
    "Will this work? " + self.a_protected_method
  end

  private

  def human_years
    age * DOG_YEARS
  end

  protected

  def a_protected_method
    "Yes, I'm protected!"
  end
end

sparky = GoodDog.new('Sparky', 4)
puts sparky.a_public_method

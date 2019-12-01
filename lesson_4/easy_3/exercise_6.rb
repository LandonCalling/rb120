class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age = 0
  end

  def make_one_year_older
    self.age += !
    # we could also write @age to avoid writing the self prefix
  end
end
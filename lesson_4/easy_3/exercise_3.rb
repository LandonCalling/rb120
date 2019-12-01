class AngryCat
  def initialize(age, name)
    @age = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

izzie = AngryCat.new(10, 'Izzie')
mitzi = AngryCat.new(5, 'Mitzi')

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts 'I am safe and driving slow.'
  end
end

# using self.class allows the go_fast method
# to print the class name in the puts statement
# so it prints "I am a Car..."

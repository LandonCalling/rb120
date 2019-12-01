class Oracle
  def predict_the_future
    'You will ' + choices.sample
  end

  def choices
    ['eat a nice lunch', 'take a nap soon', 'stay at work late']
  end
end

oracle = Oracle.new
oracle.predict_the_future

=begin
Line 11 creates a new object of the Oracle class.
Then line 12 will return a string that is "You will "
plus one of the three strings in the array in the 
choices method.
=end

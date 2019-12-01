class Oracle
  def predict_the_future
    'You will ' + choices.sample
  end

  def choices
    ['eat a nice lunch', 'take a nap soon', 'stay at work late']
  end
end

class RoadTrip < Oracle
  def choices
    ['visit Vegas', 'fly to Fiji', 'romp in Rome']
  end
end

trip = RoadTrip.new
trip.predict_the_future

=begin
The code on line 12 will return the string "You will "
plus one of the strings in the array in the choices
method in the RoadTrip class
=end
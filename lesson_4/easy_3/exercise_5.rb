class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer
# This will give a NoMethodError becuase manufacturer is an instance method
# not a class method
tv.model
#this will run the model method in the Television class

Television.manufacturer
# this will run the manufacturer class method in the Television class
Television.model
# this wil give a NoMethodError because model is an instance method
# not a class method
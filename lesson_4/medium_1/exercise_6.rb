class Computer
  attr_accessor :template

  def create_template
    @template = 'template 14321'
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = 'template 14321'
  end

  def show_template
    self.template
  end
end

# There isn't a difference.  They both reference the instance variable
# template.  In fact the self isn't needed for the show_template
# method, because you can just use the getter method for template
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
    # since quantity is being set to a new value you must
    # use @ so Ruby can distinguish this as the instance
    # variable and not a variable local to the method
    # alternatively, change attr_reader to attr_accessor
    # and use self.quantity
  end
end

# Changing attr_reader to attr_accessor will unnecessarily
# expose a getter method for the product_name variable, which
# will allow changing of the product name which is something
# you might not want
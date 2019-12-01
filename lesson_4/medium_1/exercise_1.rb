class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

=begin
Ben is.  Ben is using the balance getter implicitly defined
using the attr_reader for the balance variable.  If he used
a @ symbol and used the explicit variable then the attr_reader
wouldn't be necessary.
=end
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    # rules of play
  end
end

=begin
If we add a play method to the Bingo class,
then when play is called from a Bingo instance
it will use the play defined in the Bingo
class.  It will not change the behavior of
any Game instances.  Just the Bingo instances.
=end

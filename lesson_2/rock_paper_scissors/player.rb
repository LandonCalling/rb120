load 'score.rb'
load 'move.rb'

class Player
  VALUES ||= %w(r pa sc l sp)
  CHOICE_MAP ||= { r: 'rock',
                   pa: 'paper',
                   sc: 'scissors',
                   l: 'lizard',
                   sp: 'spock' }

  attr_accessor :move, :name, :score, :history

  def initialize
    @name = set_name
    @score = Score.new
    @history = []
  end

  def choose(choice)
    self.move = case choice
                when 'r'  then Rock.new
                when 'pa' then Paper.new
                when 'sc' then Scissors.new
                when 'sp' then Spock.new
                when 'l'  then Lizard.new
                end

    history << CHOICE_MAP[choice.to_sym]
  end
end

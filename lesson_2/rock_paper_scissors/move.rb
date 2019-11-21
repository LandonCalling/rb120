class Move
  def initialize(value, winning_moves)
    @value = value
    @beats = winning_moves
  end

  def >(other_move)
    beats.include?(other_move.value)
  end

  def to_s
    value
  end

  protected

  attr_reader :value, :beats
end

class Rock < Move
  def initialize
    super('rock', %w(scissors lizard))
  end
end

class Paper < Move
  def initialize
    super('paper', %w(rock spock))
  end
end

class Scissors < Move
  def initialize
    super('scissors', %w(paper lizard))
  end
end

class Spock < Move
  def initialize
    super('spock', %w(scissors rock))
  end
end

class Lizard < Move
  def initialize
    super('lizard', %w(spock paper))
  end
end

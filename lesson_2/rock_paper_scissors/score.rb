class Score
  attr_reader :score

  def initialize
    @score = 0
  end

  def increment
    self.score += 1
  end

  def reset
    self.score = 0
  end

  protected

  attr_writer :score
end

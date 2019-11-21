load 'player.rb'

class Computer < Player
  MOVE_TYPES = { 'R2D2'     => %w(r),
                 'Hal'      => %w(sc sc sc sc r),
                 'Chappie'  => VALUES,
                 'Sonny'    => %w(sp sp l l r),
                 'Number 5' => %w(pa r) }

  def set_name
    ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    choice = MOVE_TYPES[name].sample
    super(choice)
  end
end

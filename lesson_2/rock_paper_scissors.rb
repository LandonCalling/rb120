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

class Player
  VALUES = %w(r pa sc l sp)
  CHOICE_MAP = { r: 'rock',
                 pa: 'paper',
                 sc: 'scissors',
                 l: 'lizard',
                 sp: 'spock' }

  attr_accessor :history
  attr_reader :move, :name, :score

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

  protected

  attr_writer :move
end

class Human < Player
  def choose
    choice = ''

    loop do
      puts 'Please select from the following:'
      puts "'r' for rock"
      puts "'pa' for paper"
      puts "'sc' for scissors"
      puts "'l' for lizard"
      puts "'sp' for spock"
      choice = gets.chomp.downcase
      break if VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end

    super(choice)
  end

  private

  def set_name
    answer = ''

    loop do
      puts "What's your name?"
      answer = gets.chomp
      break unless answer.empty? || answer.size > 10 || answer.start_with?(' ')
      puts 'Sorry, must enter a value less than 10 characters that doesn\'t '\
           'start with a space.'
    end

    answer
  end
end

class Computer < Player
  MOVE_TYPES = { 'R2D2'     => %w(r),
                 'Hal'      => %w(sc sc sc sc r),
                 'Chappie'  => VALUES,
                 'Sonny'    => %w(sp sp l l r),
                 'Number 5' => %w(pa r) }

  def choose
    choice = MOVE_TYPES[name].sample
    super(choice)
  end

  private

  def set_name
    ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end
end

class RPSGame
  MAX_SCORE = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
    @round = 1
  end

  def play
    system('clear') || system('cls')
    display_welcome_message

    loop do
      loop do
        play_round
        break if max_reached?
        round_reset
        system('clear') || system('cls')
      end

      display_move_history
      break unless play_again?
      game_reset
    end

    display_goodbye_message
  end

  protected

  attr_accessor :round
  attr_reader :human, :computer

  private

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
    puts "In each round, the winner will score a point."
    puts "First one to #{MAX_SCORE} wins!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif computer.move > human.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def calculate_score
    if human.move > computer.move
      human.score.increment
    elsif computer.move > human.move
      computer.score.increment
    end
  end

  def display_score
    puts "Score after round #{round}: "\
         "#{human.name}: #{human.score.score}, "\
         "#{computer.name}: #{computer.score.score}"
  end

  def max_reached?
    human.score.score == MAX_SCORE ||
      computer.score.score == MAX_SCORE
  end

  def round_reset
    self.round += 1
    puts "The next round will start in:"
    3.downto(1) do |num|
      puts num.to_s
      sleep(1)
    end
  end

  def play_again?
    choice = ''

    loop do
      puts "Would you like to play again? (yes/no)"
      choice = gets.chomp.downcase
      break if %w(yes no y n).include?(choice)
      puts 'Sorry, invalid choice.'
    end

    %w(yes y).include?(choice)
  end

  def game_reset
    human.score.reset
    computer.score.reset
    self.round = 1
    human.history = []
    computer.history = []
  end

  def play_round
    human.choose
    computer.choose
    display_moves
    display_winner
    calculate_score
    display_score
  end

  def display_move_history
    move_history_header
    move_history_body
  end

  def move_history_header
    puts 'Move History'.center(31)
    puts "Round | #{human.name.center(10)} | #{computer.name.center(10)}"
    puts '-' * 31
  end

  def move_history_body
    1.upto(round) do |round_num|
      puts "#{round_num.to_s.center(5)} | "\
           "#{human.history[round_num - 1].center(10)} | "\
           "#{computer.history[round_num - 1].center(10)}"
    end
  end
end

RPSGame.new.play

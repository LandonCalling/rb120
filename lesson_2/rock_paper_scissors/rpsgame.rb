load 'computer.rb'
load 'human.rb'

class RPSGame
  MAX_SCORE = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
    @round = 1
  end

  def play
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

  attr_accessor :human, :computer, :round

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
         "#{human.name}: #{human.score.to_s}, "\
         "#{computer.name}: #{computer.score.to_s}"
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

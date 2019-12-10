class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]].freeze

  attr_accessor :squares

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  def display
    puts ''
    puts '     |     |'
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts '     |     |'
    puts ''
  end
  # rubocop:enable Metrics/AbcSize

  def []=(key, mark)
    squares[key].marker = mark
  end

  def full?
    empty_square_keys.empty?
  end

  def winner?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      current_line = squares.values_at(*line)

      if three_idential_markers?(current_line)
        return current_line.first.marker
      end
    end

    nil
  end

  def find_at_risk_square(mark)
    square = nil

    WINNING_LINES.each do |line|
      square = at_risk_square(line, mark)
      break if square
    end

    square
  end

  def empty_square_keys
    squares.keys.select { |key| squares[key].unmarked? }
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def three_idential_markers?(line_of_squares)
    markers = line_of_squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def at_risk_square(line, mark)
    markers = squares.values_at(*line).collect(&:marker)
    return nil unless markers.count(mark) == 2
    empty_squares = squares.select do |k, v|
      line.include?(k) && v.unmarked?
    end
    empty_squares.keys.first
  end
end

class Square
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :name
  attr_accessor :score

  def initialize(player_type)
    @marker = choose_marker(player_type)
    @name = choose_name(player_type)
    @score = 0
  end

  def score_increment
    self.score += 1
  end

  def score_reset
    self.score = 0
  end

  private

  def choose_name(player_type)
    if player_type == :human
      answer = ''

      loop do
        puts "Please enter your name:"
        answer = gets.chomp
        break unless answer.empty?
        puts 'Must enter a name.'
      end

      answer
    else
      'Johnny 5'
    end
  end

  def choose_marker(player_type)
    if player_type == :human
      answer = ''

      loop do
        puts "Please enter any one character except 'O',"
        puts "to use as your marker for this game of Tic Tac Toe."
        answer = gets.chomp.upcase
        break if answer.size == 1
        puts 'Must enter exactly one character.'
      end

      answer
    else
      'O'
    end
  end
end

class TTTGame
  FIRST_TO_MOVE = 'choose'
  MAX_SCORE = 5

  def initialize
    @board = Board.new
    @human = Player.new(:human)
    @computer = Player.new(:computer)
    @current_player = case FIRST_TO_MOVE
                      when 'choose'
                        choose_player
                      when 'player'
                        human.marker
                      when 'computer'
                        computer.marker
                      end
    @first_player = current_player
  end

  def play
    clear
    display_welcome_message

    loop do
      loop do
        display_board
        play_round
        calculate_and_display_result
        break if max_score_reached?
        round_reset
      end

      break unless play_again?
      game_reset
    end

    display_goodbye_message
  end

  protected

  attr_reader :board, :human, :computer, :first_player
  attr_accessor :current_player

  private

  def choose_player
    answer = ''
    loop do
      puts 'Please choose who goes first.'
      puts "Either 'p' for player or 'c' for computer."
      answer = gets.chomp.downcase
      break if %w(p c).include? answer
      puts 'That is not a valid choice.'
    end
    if answer == 'p'
      human.marker
    else
      computer.marker
    end
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts 'First person to 5 points wins.'
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def display_board
    puts "#{human.name} is a #{human.marker}. "\
         "#{computer.name} is a #{computer.marker}."
    board.display
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Choose a square between (#{joinor(board.empty_square_keys)}): "
    square = nil

    loop do
      square = gets.chomp.to_i
      break if board.empty_square_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    square = select_computer_move
    board[square] = computer.marker
  end

  # rubocop:disable Metrics/AbcSize
  def select_computer_move
    square = board.find_at_risk_square(computer.marker)
    square = board.find_at_risk_square(human.marker) if !square
    square = 5 if !square && board.squares[5].unmarked?
    square = board.empty_square_keys.sample if !square
    square
  end
  # ruboocop:enable Metrics/AbcSize

  def calculate_and_display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker    then human_won
    when computer.marker then computer_won
    else                      puts "It's a tie!"
    end

    puts "Current Score: #{human.name}: #{human.score}, "\
         "#{computer.name}: #{computer.score}"
  end

  def human_won
    human.score_increment
    puts "#{human.name} won!"
  end

  def computer_won
    computer.score_increment
    puts "#{computer.name} won!"
  end

  def max_score_reached?
    human.score == 5 || computer.score == 5
  end

  def play_again?
    answer = ''

    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y yes n no).include?(answer)
      puts 'Sorry, must be yes or no.'
    end

    %w(y yes).include?(answer)
  end

  def clear
    system('clear') || system('cls')
  end

  def game_reset
    round_reset
    human.score_reset
    computer.score_reset
    clear
    puts "Let's play again!"
  end

  def round_reset
    board.reset
    self.current_player = first_player
  end

  def current_player_moves
    if current_player == human.marker
      human_moves
      self.current_player = computer.marker
    else
      computer_moves
      self.current_player = human.marker
    end
  end

  def human_turn?
    current_player == human.marker
  end

  def joinor(arr, separator=', ', join_word='or')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{join_word} ")
    else
      arr[-1] = "#{join_word} #{arr.last}"
      arr.join(separator)
    end
  end

  def play_round
    loop do
      current_player_moves
      break if board.winner? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end
end

game = TTTGame.new
game.play

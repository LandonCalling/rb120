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

  def empty_square_keys
    squares.keys.select { |key| squares[key].unmarked? }
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def three_idential_markers?(line_of_squares)
    markers = line_of_squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
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
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'.freeze
  COMPUTER_MARKER = 'O'.freeze
  FIRST_TO_MOVE = HUMAN_MARKER
  MAX_SCORE = 5

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_player = FIRST_TO_MOVE
  end

  def play
    clear
    display_welcome_message

    loop do
      display_board

      loop do
        current_player_moves
        break if board.winner? || board.full?
        clear_screen_and_display_board if human_turn?
      end

      display_result
      break unless play_again?
      reset
    end

    display_goodbye_message
  end

  protected

  attr_reader :board, :human, :computer
  attr_accessor :current_player

  private

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
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
    board[board.empty_square_keys.sample] = computer.marker
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker    then puts 'You won!'
    when computer.marker then puts 'Computer won!'
    else                      puts "It's a tie!"
    end
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

  def reset
    board.reset
    self.current_player = FIRST_TO_MOVE
    clear
    puts "Let's play again!"
  end

  def current_player_moves
    if current_player == HUMAN_MARKER
      human_moves
      self.current_player = COMPUTER_MARKER
    else
      computer_moves
      self.current_player = HUMAN_MARKER
    end
  end

  def human_turn?
    current_player == HUMAN_MARKER
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
end

game = TTTGame.new
game.play

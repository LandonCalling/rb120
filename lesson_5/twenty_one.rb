module Hand
  MAXIMUM_HAND = 21

  def busted?
    total > MAXIMUM_HAND
  end

  def total
    hand_total = 0

    cards.each do |card|
      hand_total += card.score
    end

    cards.select(&:ace?).size.times do
      hand_total -= 10 if hand_total > MAXIMUM_HAND
    end

    hand_total
  end

  def draw_cards
    puts create_card_end
    puts create_card_top_value_line
    puts create_card_middle(0)
    puts create_card_middle(1)
    puts create_card_middle(2)
    puts create_card_middle(3)
    puts create_card_bottom_value_line
    puts create_card_end
  end

  def add_card(new_card)
    cards.push(new_card)
  end

  def reset
    self.cards = []
  end

  private

  def create_card_end
    string = ''

    cards.each do |card|
      string += card.draw_end
    end

    string
  end

  def create_card_top_value_line
    string = ''

    cards.each do |card|
      string += card.draw_top_value
    end

    string
  end

  def create_card_middle(line_num)
    string = ''

    cards.each do |card|
      string += card.draw_middle(line_num)
    end

    string
  end

  def create_card_bottom_value_line
    string = ''

    cards.each do |card|
      string += card.draw_bottom_value
    end

    string
  end
end

class Participant
  include Hand

  attr_accessor :name, :cards

  def initialize
    @cards = []
    set_name
  end
end

class Player < Participant
  protected

  attr_accessor :move

  public

  def set_name
    name = ''

    loop do
      puts '=> Please enter your name:'
      name = gets.chomp
      break unless name.start_with?(' ') || name.empty?
      puts "=> You must enter a name, and it can't start with a space."
    end

    self.name = name
  end

  def choose_hit_stay
    answer = ''

    loop do
      puts '=> Would you like to [h]it or [s]tay?'
      answer = gets.chomp.downcase
      break if %w(h hit s stay).include?(answer)
      puts "#{answer} is not a valid choice.  Try again."
    end

    self.move = answer
  end

  def stay?
    move == 's' || move == 'stay'
  end
end

class Dealer < Participant
  NAMES = ['Chappie', 'Johnny 5', 'Wall-E', 'Eve']
  DEALER_STAY = 17

  def set_name
    self.name = NAMES.sample
  end

  def stay?
    total >= DEALER_STAY
  end
end

class Deck
  SUITS = [:hearts, :spades, :clubs, :diamonds]
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

  attr_accessor :cards

  def initialize
    @cards = []
    reset
  end

  def deal
    cards.pop
  end

  def reset
    card_set = SUITS.product(VALUES)
    card_set.shuffle!

    card_set.each do |suit, value|
      cards.push(Card.new(suit, value))
    end
  end
end

class Card
  HEART_CARD   = ['|  _ _  |  ',
                  '| ( V ) |  ',
                  '|  \ /  |  ',
                  '|   V   |  ']
  CLUB_CARD    = ['|   _   |  ',
                  '|  ( )  |  ',
                  "| (_'_) |  ",
                  '|   |   |  ']
  DIAMOND_CARD = ['|   .   |  ',
                  '|  / \  |  ',
                  '|  \ /  |  ',
                  '|   V   |  ']
  SPADE_CARD   = ['|   .   |  ',
                  '|  /.\  |  ',
                  '| (_._) |  ',
                  '|   |   |  ']
  UNK_CARD     = ['|  / \  |  ',
                  '|    /  |  ',
                  '|   |   |  ',
                  '|   .   |  ']

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def draw_end
    '+-------+  '
  end

  def draw_top_value
    if value == 10
      "|#{value}     |  "
    else
      "|#{value}      |  "
    end
  end

  def draw_middle(line)
    case suit
    when :hearts   then HEART_CARD[line]
    when :clubs    then CLUB_CARD[line]
    when :diamonds then DIAMOND_CARD[line]
    when :spades   then SPADE_CARD[line]
    else                UNK_CARD[line]
    end
  end

  def draw_bottom_value
    if value == 10
      "|     #{value}|  "
    else
      "|      #{value}|  "
    end
  end

  def score
    case value
    when 'J', 'Q', 'K' then 10
    when 'A'           then 11
    else                    value
    end
  end

  def ace?
    value == 'A'
  end
end

class Game
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
    @turn = 'player'
  end

  def start
    display_welcome_message
    deal_cards
    display_cards
    player_turn
    display_cards
    dealer_turn unless player.busted?
    show_result
    display_goodbye_message
  end

  protected

  attr_writer :player
  attr_accessor :turn

  private

  attr_reader :player, :dealer, :deck

  def display_welcome_message
    prompt("Welcome to Twenty One, #{player.name}!")
    prompt('In this game you will be playing against the dealer.')
    prompt('You and the dealer will each be dealt 2 cards.')
    prompt('Player goes first, and can either hit or stay.')
    prompt('If either you or the dealer get over 21 they bust.')
    prompt('Hit ENTER to start the game.')
    gets.chomp
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal)
      dealer.add_card(deck.deal)
    end
  end

  def player_turn
    loop do
      player.choose_hit_stay
      break if player.stay?
      player.add_card(deck.deal)
      display_cards
      break if player.busted?
    end

    self.turn = 'dealer'
  end

  def dealer_turn
    loop do
      break if dealer.stay? || dealer.busted?
      dealer.add_card(deck.deal)
      display_cards
      sleep(1)
    end
  end

  def display_cards
    system('clear') || system('cls')
    print_dealer_hand
    print_player_hand
  end

  # rubocop: disable Metrics/AbcSize
  def print_dealer_hand
    placeholder = nil

    if turn == 'player'
      placeholder = dealer.cards[0]
      dealer.cards[0] = Card.new(:unknown, '?')
    end

    prompt("#{dealer.name} hand:")
    dealer.draw_cards

    unless turn == 'player'
      prompt("#{dealer.name} current total: #{dealer.total}")
    end

    dealer.cards[0] = placeholder if placeholder
  end
  # rubocop: enable Metrics/AbcSize

  def print_player_hand
    prompt("#{player.name} hand:")
    player.draw_cards
    prompt("#{player.name} current total: #{player.total}")
  end

  # rubocop: disable Metrics/AbcSize
  def show_result
    if player.busted?
      prompt("#{player.name} busted!  #{dealer.name} wins!")
    elsif dealer.busted?
      prompt("#{dealer.name} busted!  #{player.name} wins!")
    elsif player.total > dealer.total
      prompt("#{player.name} wins!")
    elsif dealer.total > player.total
      prompt("#{dealer.name} wins!")
    else
      prompt("Game is a tie!")
    end
  end
  # rubocop: enable Metrics/AbcSize

  def display_goodbye_message
    prompt("Thanks for playing Twenty One, #{player.name}!")
  end
end

system('clear') || system('cls')
Game.new.start

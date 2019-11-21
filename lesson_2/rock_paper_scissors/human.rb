load 'player.rb'

class Human < Player
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
end

require_relative './lib/game'

def run_game(secret_numbers = nil, input: $stdin, output: $stdout)
  output.puts "Welcome to the Number Guessing Game!"
  output.puts "I'm thinking of a number between 1 and 100."

  difficulty_map = { 1 => :easy, 2 => :medium, 3 => :hard }

  loop do
    choice = nil
    output.puts "\nPlease select the difficulty level:"
    output.puts "1. Easy (10 chances)"
    output.puts "2. Medium (7 chances)"
    output.puts "3. Hard (5 chances)"

    loop do
      output.print "Enter difficulty choice (1-3): "
      choice_input = input.gets.chomp

      if choice_input.match?(/^\d$/) && difficulty_map.key?(choice_input.to_i)
        choice = choice_input.to_i
        break
      else
        output.puts "Invalid input. Please enter a number between 1 and 3."
      end
    end

    difficulty = difficulty_map[choice]
    secret = secret_numbers&.shift || rand(1..100)
    game = Game.new(secret, difficulty: difficulty)

    output.puts "\nYou have #{game.allowed_guesses} guesses on #{difficulty.to_s.capitalize} mode. Good luck!"

    loop do
      output.puts "\nGuesses remaining: #{game.guesses_remaining}"

      guess = nil
      loop do
        output.print "Enter your guess (1–100): "
        guess_input = input.gets.chomp

        if guess_input.match?(/^\d+$/)
          guess = guess_input.to_i
          if guess.between?(1, 100)
            break
          else
            output.puts "Please enter a number between 1 and 100."
          end
        else
          output.puts "Invalid input. Please enter a whole number."
        end
      end

      result = game.check_guess(guess)

      case result
      when :no_guesses_left
        output.puts "You've run out of guesses! The number was #{secret}."
        break
      when :correct
        output.puts "Correct! You guessed the number in #{game.guess_count} guesses."
        break
      when :low
        output.puts "Too low. Try a higher number!"
      when :high
        output.puts "Too high. Try a lower number!"
      end
    end

    output.print "\nDo you want to play again? (yes/no): "
    play_again = input.gets.chomp.downcase
    break unless play_again == "yes"
  end

  output.puts "Thanks for playing! Goodbye."
end

run_game if __FILE__ == $PROGRAM_NAME

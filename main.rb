require_relative './lib/game'

puts "Welcome to the Number Guessing Game!"
puts "I'm thinking of a number between 1 and 100."

difficulty_map = { 1 => :easy, 2 => :medium, 3 => :hard }
choice = nil
puts "\nPlease select the difficulty level:"
puts "1. Easy (10 chances)"
puts "2. Medium (7 chances)"
puts "3. Hard (5 chances)"
loop do
  print "Enter difficulty choice (1-3): "
  input = gets.chomp

  if input.match?(/^\d$/) && difficulty_map.key?(input.to_i)
    choice = input.to_i
    break
  else
    puts "Invalid input. Please enter a number between 1 and 3."
  end
end
difficulty = difficulty_map[choice]
secret = rand(1..100)
game = Game.new(secret, difficulty: difficulty)

puts "\nYou have #{game.allowed_guesses} guesses. Good luck!"

loop do
  puts "\nGuesses remaining: #{game.guesses_remaining}"

  guess = nil
  loop do
    print "Enter your guess (1–100): "
    input = gets.chomp

    if input.match?(/^\d+$/)
      guess = input.to_i
      if guess.between?(1, 100)
        break
      else
        puts "Please enter a number between 1 and 100."
      end
    else
      puts "Invalid input. Please enter a whole number."
    end
  end

  result = game.check_guess(guess)

  case result
  when :no_guesses_left
    puts "You've run out of guesses! The number was #{secret}."
    break
  when :correct
    puts "Correct! You guessed the number!"
    break
  when :low
    puts "Too low. Try a higher number!"
  when :high
    puts "Too high. Try a lower number!"
  end
end

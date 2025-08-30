require_relative './lib/game'

puts "Welcome to the Number Guessing Game!"
puts "I'm thinking of a number between 1 and 100."
puts "Please select the difficulty level:"
puts "1. Easy (10 chances)"
puts "2. Medium (7 chances)"
puts "3. Hard (5 chances)"
print "Enter difficulty choice (1-3): "
choice = gets.chomp.to_i

difficulty_map = { 1 => :easy, 2 => :medium, 3 => :hard }
difficulty = difficulty_map[choice] || :medium

secret = rand(1..100)
game = Game.new(secret, difficulty: difficulty)
puts "You have #{game.allowed_guesses} guesses. Good luck!"

loop do
  puts "\nGuesses remaining: #{game.guesses_remaining}"
  print "Enter your guess: "
  guess = gets.chomp.to_i
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

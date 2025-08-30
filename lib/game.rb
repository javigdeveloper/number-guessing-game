class Game
  attr_reader :secret_number, :allowed_guesses, :guess_count

  DIFFICULTY_LEVELS = {
    easy: 10,
    medium: 7,
    hard: 5
  }

  def initialize(secret_number, difficulty:)
    @allowed_guesses = DIFFICULTY_LEVELS[difficulty]
    raise ArgumentError, "Invalid difficulty level: #{difficulty}" unless @allowed_guesses
    @secret_number = secret_number
    @difficulty = difficulty
    @guess_count = 0
  end

  def guesses_remaining
    allowed_guesses - guess_count
  end
  
  def check_guess(guess)
    @guess_count += 1
    return :no_guesses_left if guesses_remaining < 1
    return :correct if guess == @secret_number
    return :low if guess < @secret_number
    :high
  end
end

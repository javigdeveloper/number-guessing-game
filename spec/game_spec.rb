require_relative '../lib/game'

describe Game do
  describe "initialization" do
    it "can be created" do
      game = Game.new(42, difficulty: :easy)
      expect(game).to be_a(Game)
    end

    it "stores a secret number when initialized" do
      game = Game.new(42, difficulty: :easy)
      expect(game.secret_number).to eq(42)
    end
  end

  describe "#check_guess" do
    context "when the guess matches the secret number" do
      it "returns :correct" do
        game = Game.new(42, difficulty: :easy)
        result = game.check_guess(42)
        expect(result).to eq(:correct)
      end
    end

    context "when the guess is lower than the secret number" do
      it "returns :low" do
        game = Game.new(50, difficulty: :easy)
        result = game.check_guess(30)
        expect(result).to eq(:low)
      end
    end

    context "when the guess is higher than the secret number" do
      it "returns :high" do
        game = Game.new(50, difficulty: :easy)
        result = game.check_guess(70)
        expect(result).to eq(:high)
      end
    end
  end

  describe "#allowed_guesses" do
    context "when difficulty is :easy" do
      it "allows 10 guesses" do
        game = Game.new(50, difficulty: :easy)
        expect(game.allowed_guesses).to eq(10)
      end
    end

    context "when difficulty is :medium" do
      it "allows 7 guesses" do
        game = Game.new(50, difficulty: :medium)
        expect(game.allowed_guesses).to eq(7)
      end
    end

    context "when difficulty is :hard" do
      it "allows 5 guesses" do
        game = Game.new(50, difficulty: :hard)
        expect(game.allowed_guesses).to eq(5)
      end
    end
  end

  describe "guess tracking" do
    it "tracks how many guesses have been made" do
      game = Game.new(42, difficulty: :easy)
      expect(game.respond_to?(:guess_count)).to be true

      expect(game.guess_count).to eq(0)
      game.check_guess(10)
      expect(game.guess_count).to eq(1)
      game.check_guess(20)
      expect(game.guess_count).to eq(2)
    end

    it "calculates remaining guesses correctly" do
      game = Game.new(42, difficulty: :medium)
      expect(game.guesses_remaining).to eq(7)
      game.check_guess(30)
      expect(game.guesses_remaining).to eq(6)
      3.times { game.check_guess(10) }
      expect(game.guesses_remaining).to eq(3)
    end

    it "does not allow guesses after reaching the limit" do
      game = Game.new(42, difficulty: :hard)
      5.times { game.check_guess(1) }
      expect(game.guesses_remaining).to eq(0)
      result = game.check_guess(42)
      expect(result).to eq(:no_guesses_left) # You can choose a different symbol if you prefer
    end
  end

end

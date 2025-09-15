require 'spec_helper'
require_relative '../main'

RSpec.describe 'Number Guessing CLI App' do
  class FakeIO
    attr_reader :output

    def initialize(inputs)
      @inputs = inputs
      @output = ""
    end

    def gets
      @inputs.shift
    end

    def puts(str)
      @output << str + "\n"
    end

    def print(str)
      @output << str
    end
  end

  it 'allows the user to play again after running out of guesses' do
    fake_io = FakeIO.new([
      "1",                      # Select easy mode
      *Array.new(10, "1"),      # 10 incorrect guesses
      "yes",                    # Play again
      "1",                      # Easy again
      *Array.new(10, "1"),      # Another 10 incorrect guesses
      "no"                      # Exit
    ])

    run_game([42, 99], input: fake_io, output: fake_io)

    expect(fake_io.output).to include("play again")
    expect(fake_io.output).to include("Thanks for playing")
  end
end

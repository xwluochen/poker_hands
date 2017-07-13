module Poker
  class Card
    attr_reader :value, :suit

    def initialize(value,suit)
      @value, @suit = value, suit
    end

    def ==(other)
      value == other.value && suit == other.suit
    end
  end
end
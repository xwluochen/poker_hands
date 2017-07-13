module Poker
  class Hand
    include Comparable
    VALUES = %w{2 3 4 5 6 7 8 9 T J Q K A}
    SUITES = %w{C D H S} #clubs, diamonds, hearts, spades
    RANKS = [:high_card, :one_pair, :two_pairs, :three_of_a_kind, :straight, :flush, :full_house,
              :four_of_a_kind, :straight_flush, :royal_flush]

    attr_reader :cards, :value_counts, :suit_counts 

    def initialize(cards)
      # hand cards
      # replace all blank space, then split this into an array with each element containing two characters
      # first char is rank, the second is suit
      @cards = cards.gsub(/\s+/, "")
                    .scan(/.{2}/)
                    .map{|ch| Card.new(ch[0],ch[1])}

      # each value shows times in the hand card
      @value_counts = Hand::VALUES.collect {|value| value_count(value)}

      # each suit shows times in the hand card
      @suit_counts = Hand::SUITES.collect{|suit| suit_count(suit)}
    end

    def rank
      # check special cases
      return :royal_flush    if royal_flush?
      return :straight_flush if straight? && flush?
      return :flush          if flush?
      return :straight       if straight?

      value_counts_sorted = value_counts.sort.reverse

      # assigned rank based on value show counts
      return {
        [4,1] => :four_of_a_kind,
        [3,2] => :full_house,
        [3,1] => :three_of_a_kind,
        [2,2] => :two_pairs,
        [2,1] => :one_pair,
        [1,1] => :high_card
      }[value_counts_sorted[0..1]]
    end

    # compare who will win
    # if two players have the same ranked hands then the ranke make up of the higeset values winds
    def <=>(other)
      keys <=> other.keys
    end
    
    def keys
      [ranking, value_counts]
    end

  private

    def ranking
       Hand::RANKS.index(rank)
    end

     #if there are 5 continouse 1, then it's consecutive values
    def straight?
      value_counts.join().include? '11111'
    end

    # there is one suit show 5 times, then it's same suit
    def flush?
      suit_counts.any?{|n| n == 5}
    end

    # T, J, Q, K, A shows and also same suit
    def royal_flush?
      value_counts[-5, 5]==[1,1,1,1,1] && flush?
    end

    def value_count(value)
      cards.count{|card| card.value == value}
    end

    def suit_count(suit)
      cards.count{|card| card.suit == suit}
    end
  end
end
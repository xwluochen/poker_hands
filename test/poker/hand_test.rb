require 'test_helper'

module Poker
  class HandTest < ActiveSupport::TestCase
    test 'hand creation' do
      hand = Hand.new("2H 4S 4C 2D 4H")
      assert_equal Card.new('2',"H"), hand.cards[0]
      assert_equal Card.new('4',"S"), hand.cards[1]
      assert_equal Card.new('4',"C"), hand.cards[2]
      assert_equal Card.new('2',"D"), hand.cards[3]
      assert_equal Card.new('4',"H"), hand.cards[4]
    end

    test 'test_hand_ranked_high_card' do
      assert_equal :high_card, Hand.new("2C 3H 4S 8C AH").rank
    end

    test 'test_hand_ranked_one_pair' do
      assert_equal :one_pair, Hand.new("2H 4S 5C JD 4H").rank
    end

    test 'test_hand_ranked_two_pairs' do
      assert_equal :two_pairs, Hand.new("2H 4S 5C 2D 4H").rank
    end

    test 'test_hand_ranked_three_of_a_kind' do
      assert_equal :three_of_a_kind, Hand.new("2H 4S 4C AD 4H").rank
    end

    test 'test_hand_ranked_straight' do
      assert_equal :straight, Hand.new("2H 3C 4H 5H 6H").rank
    end

    test 'test_hand_ranked_flush' do
      assert_equal :flush, Hand.new("2H 4H 6H 8H TH").rank
    end

    test 'test_hand_ranked_full_house' do
      assert_equal :full_house, Hand.new("2H 4S 4C 2D 4H").rank
    end

    test 'test_hand_ranked_four_of_a_kind' do
      assert_equal :four_of_a_kind, Hand.new("2H 4S 4C 4D 4H").rank
    end

    test 'test_hand_ranked_straight_flush' do
      assert_equal :straight_flush, Hand.new("2H 4H 3H 5H 6H").rank
    end

    test 'test_hand_ranked_royal_flush' do
      assert_equal :royal_flush, Hand.new("TC JC QC KC AC").rank
    end

    test 'test_full_house_beats_flush' do
      hand1 = Hand.new("2H 4S 4C 2D 4H")    
      hand2 = Hand.new("2S 8S AS QS 3S")
      assert_equal 1, hand1 <=> hand2
    end

    test 'test_higher_card_wins_if_equal_rank' do
      hand1 = Hand.new("2H 3D 5S 9C KD")
      assert_equal :high_card, hand1.rank
      hand2  = Hand.new("2C 3H 4S 8C AH")
      assert_equal :high_card, hand2.rank
      assert_equal -1, hand1 <=> hand2
    end

    test 'test_equal_hands' do
      hand1 = Hand.new("2H 3D 5S 9C KD")
      assert_equal :high_card, hand1.rank
      hand2 = Hand.new("2D 3H 5C 9S KH")
      assert_equal :high_card, hand2.rank
      assert_equal 0, hand1 <=> hand2
    end
  end
end
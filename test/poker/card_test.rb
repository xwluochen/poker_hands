require 'test_helper'

module Poker
	class CardTest < ActiveSupport::TestCase
	  def setup
	    @card = Card.new('3',"C")
	  end

	  test 'card has value set on creation' do
	    assert_equal '3', @card.value
	  end


	  test 'card has suit set on creation' do
	    assert_equal "C", @card.suit
	  end
	end
end
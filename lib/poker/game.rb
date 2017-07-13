require 'net/http'
require 'open-uri'

module Poker
  class Game
    def self.play   
      url = "https://projecteuler.net/project/resources/p054_poker.txt"
      player1_win_count = 0

      # open connection, then read each line
      open(url) do |f|
        f.each_line do |l|
          player1 = Hand.new(l[0..13])
          player2 = Hand.new(l[15..28])

          # if player1 wins, increment count
          if player1 > player2
            player1_win_count = player1_win_count + 1
          end
        end
      end
      
      # out put how many times player win
      puts(player1_win_count) 
    end
  end
end
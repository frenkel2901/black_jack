#require_relative 'card_counter'

ALL_CARDS = [ 2, 3, 4, 5, 6 ,7 ,8 ,9, 10, 'J', 'Q', 'K', 'A' ].freeze
SUITS = [ '♧', '♡', '♤', '♢' ].freeze

class Deck
  #include CardCounter

  attr_accessor :sum
  attr_reader :given, :given_now

  def give_card
    @given ||= []
    @given_now = "#{ALL_CARDS.sample}#{SUITS.sample}"
    gived?
    @given << @given_now
    puts @given_now
  end

  private

  def gived?
    raise "Already given!" if @given.include?(@given_now)
  end
end

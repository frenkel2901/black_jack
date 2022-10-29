require_relative 'deck'
require_relative 'card_counter'

class Menu

  @@deck = { 'd' => nil }

def set_table #подготавливаем стол к игре
  deck = Deck.new
  @@deck['d'] = deck
end

def card_on_deck #вытаскиваем 1 карту на стол
  @@deck['d'].give_card

  cards_on_hands = @@deck['d'].given
  sum = @@deck['d'].all_sum
  puts "Cards on hands: #{cards_on_hands}, summar #{sum}"

  rescue RuntimeError => e
    puts "#{e}"
  retry
end

def clear_deck  #очищаем стол после игры
  @@deck.delete("d")
end

end

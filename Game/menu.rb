require_relative 'deck'

class Menu

  @@deck = { 'd' => nil }

def set_table #подготавливаем стол к игре
  deck = Deck.new
  @@deck['d'] = deck
end

def card_on_deck #вытаскиваем 1 карту на стол
  @@deck['d'].give_card

  rescue RuntimeError => e
    puts "#{e}"
  retry
end

def clear_deck  #очищаем стол после игры
  @@deck.delete("d")
end

end

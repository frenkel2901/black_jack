CHOISE = [
  {num: 1, title: "Skip"},
  {num: 2, title: "Add card"},
  {num: 3, title: "Open cards"}
]

class Menu

  def initialize
    @deck = {}
    @user = {} 
    @dealer = {}

    start_game
  end

  def start_game
    print "Enter your name: "
    name = gets.chomp.to_s.capitalize
    user = User.new(name)
    dealer = Dealer.new("#{name}s dealer")

    @user[:user] = user
    @dealer[:dealer] = dealer

    puts "You have #{user.bank - 10}$"
    dealer.bank -= 10
    @bet = 10 + 10
    set_table
  end

  def set_table #подготавливаем стол к игре
    deck = Deck.new
    @deck['d'] = deck

    for i in (0..1)
      card_on_deck
      @user[:user].given << (@deck['d'].given_now)
      @sum = @user[:user].all_sum
    end

    for i in (0..1)
      card_on_deck
      @dealer[:dealer].given << (@deck['d'].given_now)
      @sum = @dealer[:dealer].all_sum
    end

    puts "Your hand: #{@user[:user].given}, summary #{@user[:user].all_sum} points"
  end

  def card_on_deck #вытаскиваем 1 карту на стол
    @deck['d'].give_card

    rescue RuntimeError => e
      puts "#{e}"
    retry
  end

  def clear_deck  #очищаем стол после игры
    @deck.delete("d")
  end

  def user_add_card
    card_on_deck
    @user[:user].given << (@deck['d'].given_now)
    @sum = @user[:user].all_sum

    puts "Your hand: #{@user[:user].given}, summary #{@user[:user].all_sum} points"
  end

  def dealer_choise
    if @dealer[:dealer].all_sum < 17
      card_on_deck
      @dealer[:dealer].given << (@deck['d'].given_now)
      @sum = @dealer[:dealer].all_sum
    end
  end

end

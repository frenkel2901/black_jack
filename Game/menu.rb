CHOISE = [
  {num: 1, title: "Skip", todo: :skip},
  {num: 2, title: "Add card", todo: :user_add_card},
  {num: 3, title: "Open cards", todo: :open_cards}
]

class Menu

  def initialize
    @deck = {}
    @user = {}
    @dealer = {}
  end

  def start
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

    puts "Your hand: #{@user[:user].given}, summary #{@user[:user].sum} points"

    your_choise
  end

  def card_on_deck #вытаскиваем 1 карту на стол
    @deck['d'].give_card

    rescue RuntimeError => e
      puts "#{e}"
    retry
  end

  def your_choise
    loop do
      CHOISE.each do |list|
        puts "#{list[:num]} - #{list[:title]}"
      end
      puts '0 - End game'
      choise = gets.chomp.to_i
      todo_hash = CHOISE.find { |list| list[:num] == choise}
      send(todo_hash[:todo]) unless todo_hash.nil?
      break if choise.zero?
    end
  end

  def user_add_card
    if @user[:user].given.size.to_i > 2
      puts "You already have 3 cards! Lets open"
      open_cards
    else
      card_on_deck
      @user[:user].given << (@deck['d'].given_now)
      @sum = @user[:user].all_sum
    end

    puts "Your hand: #{@user[:user].given}, summary #{@user[:user].all_sum} points"
  end

  def skip
    if @user[:user].given.size.to_i > 2
      puts "You already have 3 cards! Lets open"
      open_cards
    else
      puts "Skip"
    end
  end
  
  def open_cards
    puts "Your hand: #{@user[:user].given}, summary #{@user[:user].all_sum} points"
    puts "Dealer hand #{@dealer[:dealer].given}, summary #{@dealer[:dealer].all_sum} points"

    u_sum = (21 - @user[:user].all_sum.to_i)
    p_sum = (21 - @dealer[:dealer].all_sum.to_i)
    u_p = u_sum - p_sum
    puts u_p

    if p_sum < 0 || (p_sum >= 0 && u_sum >= 0 && u_p < 0)
      @user[:user].bank += @bet.to_i
      puts "Dealer symmary > 21, you win! Your bank #{@user[:user].bank}$"
    elsif u_sum == p_sum
      puts "Draw!"
      @user[:user].bank += 10
      @dealer[:dealer].bank += 10
    elsif p_sum >= 0 && u_sum >= 0 && u_p > 0
      @user[:user].bank -= @bet.to_i
      puts "You loose. Your bank #{@user[:user].bank}$"
    else
    end
    Menu.new.set_table
  end

  def dealer_choise
    puts "Dealer choise"
    sleep 3
    if @dealer[:dealer].all_sum < 17
      card_on_deck
      @dealer[:dealer].given << (@deck['d'].given_now)
      @sum = @dealer[:dealer].all_sum
    end

    puts "#{@dealer[:dealer].given.size.times { print "*"} }"
  end

  def clear_deck  #очищаем стол после игры
    @deck.delete("d")
  end

end

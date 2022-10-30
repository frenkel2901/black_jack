module CardCounter
  CARD_VALUE = { 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => [1, 11] }

  def all_sum
    @sum = 0
    @given.each do |card|
      value = card.to_s.chop
      if CARD_VALUE[value].nil?
        @sum += value.to_i
      elsif value == 'A'
        @sum += CARD_VALUE[value][0].to_i if @sum > (21 - 11)
        @sum += CARD_VALUE[value][1].to_i if @sum < (21 - 11)
      else
        @sum += CARD_VALUE[value].to_i
      end
    end
  end
end

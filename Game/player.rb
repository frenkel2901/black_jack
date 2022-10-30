class User
  include CardCounter

  attr_accessor :bank, :given
  attr_reader :name

  def initialize(name)
    @name = name
    @bank = 100
    @given = []
  end

end

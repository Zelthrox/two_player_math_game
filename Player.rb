class Player
  attr_reader :name
  attr_reader :num_win
  attr_reader :num_loss
  attr_reader :life

  def initialize (name)
    @name = name
    @num_win = 0
    @num_loss = 0
    @life = 3
  end

  def win_point
    @num_win += 1
  end

  def lose_point
    @num_loss += 1
  end

  def lose_life
    @life -= 1
  end

  def reset
    @life = 3
  end
end

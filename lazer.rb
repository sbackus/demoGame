class Lazer
  attr_reader :x, :y
  def initialize(x)
    @image = Gosu::Image.new("images/lazer.png")
    @x = x + 15
    @y = Game::HEIGHT-60
    @z = 0
  end

  def update
    @y -= 6
  end

  def draw
    @image.draw(@x,@y,@z)
  end

end

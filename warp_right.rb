class WarpRight
  attr_reader :x, :y
  def initialize
    @image = Gosu::Image.new("images/RightArrow.png")
    @x = rand(Game::WIDTH-@image.width)
    @y = 0
    @z = 0
  end

  def update
    @y += 5
  end

  def draw
    @image.draw(@x,@y,@z)
  end

end

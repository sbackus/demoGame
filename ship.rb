class Ship
  attr_reader :x, :y
  attr_accessor :power_ups
  def initialize
    @power_ups = 0
    @image = Gosu::Image.new("images/ship.gif")
    @x = Game::WIDTH/2 - @image.width
    @y = Game::HEIGHT - @image.height
    @z = 0
    @speed = 5
  end

  def update
    if Gosu::button_down? Gosu::KbLeft
      @x -= @speed
    elsif Gosu::button_down? Gosu::KbRight
      @x += @speed
    elsif Gosu::button_down? Gosu::KbUp
      @y -= @speed
    elsif Gosu::button_down? Gosu::KbDown
      @y += @speed
    end
  end

  def draw
    @image.draw(@x,@y,@z)
  end
end

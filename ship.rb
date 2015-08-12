class Ship
  attr_reader :x, :y
  def initialize
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
    end
  end

  def draw
    @image.draw(@x,@y,@z)
  end
end

class Asteroid
    attr_reader :x, :y
    def initialize
        @image = Gosu::Image.new("images/asteroid.gif")
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

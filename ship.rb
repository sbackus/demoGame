class Ship
  attr_reader :x, :y
  attr_accessor :power_ups, :warps
  def initialize
    @power_ups = 0
    @image = Gosu::Image.new("images/ship.gif")
    @x = Game::WIDTH/2 - @image.width
    @y = Game::HEIGHT - @image.height
    @z = 0
    @speed = 5
    @warps = 0
    @warp_cooldown = 0
  end

  def update
    if Gosu::button_down? Gosu::KbLeft
      @x -= @speed
    end
    if Gosu::button_down? Gosu::KbRight
      @x += @speed
    end
    if Gosu::button_down? Gosu::KbUp
      @y -= @speed
    end
    if Gosu::button_down? Gosu::KbDown
      @y += @speed
    end
    if @warp_cooldown > 0
      @warp_cooldown -= 1
    end
    if @warps > 0
      if Gosu::button_down? Gosu::KbA
        @x -= 50
        @warp_cooldown = 30
        @warps -= 1
      elsif Gosu::button_down? Gosu::KbD
        @x += 50
        @warp_cooldown = 30
        @warps -= 1
      end
    end
  end

  def draw
    @image.draw(@x,@y,@z)
  end
end

require "gosu"
require "./ship"
require "./asteroid"
require "./lazer"
require "./power_up"

class Game < Gosu::Window
  WIDTH = 768
  HEIGHT = 576

  def initialize
    super(WIDTH, HEIGHT, false)
    @space_ship = Ship.new
    @asteroids = []
    @lazers = []
    @lazer_cooldown = 0
    @lazer_cooldown_time = 30
    @lazer_sound = Gosu::Sample.new("sounds/laser.wav")
    @explosion_sound = Gosu::Sample.new("sounds/explosion.wav")
    @game_over = false
    @font = Gosu::Font.new(50)
    @timer = 0.0
    @power_ups = []
    @warps = []
  end

  def update
    @timer += 0.000017
    if !@game_over
      @space_ship.update
      if rand < 0.0015
        @power_ups << PowerUp.new
      end
      if rand < 0.05 + @timer
        @asteroids << Asteroid.new
      end
      @power_ups.each do |pu|
        pu.update
        if Gosu::distance(pu.x, pu.y, @space_ship.x, @space_ship.y) < 20
          @power_ups.delete(pu)
          @space_ship.power_ups +=1
        end
      end
      @asteroids.each do |asteroid|
        asteroid.update
        if Gosu::distance(@space_ship.x, @space_ship.y, asteroid.x, asteroid.y) < 30
          @game_over = true
          @explosion_sound.play
        end
      end
      @asteroids.reject! do |asteroid|
        asteroid.y > HEIGHT
      end
      if Gosu::button_down?(Gosu::KbSpace) && @lazer_cooldown <= 0
        @lazer_cooldown = @lazer_cooldown_time
        @lazers << Lazer.new(@space_ship.x)
        @lazer_sound.play
      end
      if @lazer_cooldown > 0
        @lazer_cooldown -= 1+@space_ship.power_ups
      end
      @lazers.each do |lazer|
        lazer.update
        @asteroids.each do |asteroid|
          if Gosu::distance(lazer.x, lazer.y, asteroid.x, asteroid.y) < 20
            @lazers.delete(lazer)
            @asteroids.delete(asteroid)
            @explosion_sound.play
          end
        end
      end
      @lazers.reject! do |lazer|
        lazer.y < 0
      end
    end

  end

  def draw
    if @game_over
      @font.draw("Game Over", WIDTH/2-140, HEIGHT/2-50, 1)
    else
      @font.draw((@timer*1000).round, 0, 0, 1)
      @space_ship.draw
      @power_ups.each do |pu|
        pu.draw
      end
      @asteroids.each do |asteroid|
        asteroid.draw
      end
      @lazers.each do |lazer|
        lazer.draw
      end
    end
  end
end

Game.new.show

Ball   = require 'entity.ball'
Paddle = require 'entity.paddle'

function love.load()
    paused = false
    gamelost = false
    love.graphics.setMode(640,400, false, true, 4);
   ball = Ball:init()

   background = love.graphics.newImage("img/background.png")

   gameoversnd = love.audio.newSource("snd/game_over.wav", "static")

   paddle1 = Paddle.init(love.graphics.getWidth() / 2, 10, "a", "d", "top")
   paddle2 = Paddle.init(love.graphics.getWidth() / 2, love.graphics.getHeight() - 20)
   
   local f = love.graphics.newFont(11)
   love.graphics.setFont(f)
   love.graphics.setBackgroundColor(0,0,0) --,255,255)
end

function love.update(dt)
    if(gamelost) then
        love.graphics.setColor(255,255,255,255)
        love.graphics.print('GAME OVER', 10, 10)
    end

    if(gamelost == false and paused == false) then

        --invincible ai
        paddle1.x = (ball.x + (ball.radius / 2)) - (paddle1.width / 2);

        ball:update(dt)
        paddle1:update(dt)
        paddle2:update(dt)
    end
end

function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   end

    if key == " " then
        if(paused) then
            paused = false
        else
            paused = true
        end
    end
end

function gameover()
    love.audio.play(gameoversnd)
    gamelost = true
end

function love.draw()
    love.graphics.draw(background)
    ball:draw()
    paddle1:draw()
    paddle2:draw()
    
end
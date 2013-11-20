Ball = require 'entity.ball'

function love.load()

   ball = Ball()

   x = love.graphics.getWidth() / 2
   y = love.graphics.getHeight() - 30
   x2 = love.graphics.getWidth() / 2
   y2 = 10

   by = love.graphics.getHeight() / 2
   bx = love.graphics.getWidth() / 2

   bax = 300
   bay = 300
   
   local f = love.graphics.newFont(24)
   love.graphics.setFont(f)
   love.graphics.setColor(0,0,0,255)
   love.graphics.setBackgroundColor(0,0,0) --,255,255)
   --love.graphics.toggleFullscreen()
end

function drawPaddles()
    love.graphics.setColor(255,255,255,255)
    love.graphics.rectangle("fill", x, y, 100, 20)
    love.graphics.rectangle("fill", x2, y2, 100, 20)
end

function drawBall()
    love.graphics.setColor(0,255,255,255)
    love.graphics.circle("fill", bx, by, 10, 100)
end

function updateBall(dt)
    
end

function love.update(dt)

    --updateBall(dt)
    ball.update(dt)

    if(love.keyboard.isDown("up")) then
        --y = y - 1
    end

    if(love.keyboard.isDown("down")) then
        --y = y + 1
    end

    if(love.keyboard.isDown("right")) then
        x = x + 5
    end

    if(love.keyboard.isDown("left")) then
        x = x - 5
    end

    if(love.keyboard.isDown("d")) then
        x2 = x2 + 5
    end

    if(love.keyboard.isDown("a")) then
        x2 = x2 - 5
    end
end

function love.draw()
    drawPaddles()
    ball.draw()
end
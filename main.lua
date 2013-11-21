Ball   = require 'entity.ball'
Paddle = require 'entity.paddle'

function love.load()

   ball = Ball:init()

   x = love.graphics.getWidth() / 2
   y = love.graphics.getHeight() - 30
   x2 = love.graphics.getWidth() / 2
   y2 = 10

   
   local f = love.graphics.newFont(11)
   love.graphics.setFont(f)
   love.graphics.setBackgroundColor(0,0,0) --,255,255)
   --love.graphics.toggleFullscreen()
end

function drawPaddles()
    love.graphics.setColor(255,255,255,255)
    love.graphics.rectangle("fill", x, y, 100, 20)
    love.graphics.rectangle("fill", x2, y2, 100, 20)
end

function love.update(dt)

    ball:update(dt)

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
    ball:draw()
end
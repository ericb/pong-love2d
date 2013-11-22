Ball   = require 'entity.ball'
Paddle = require 'entity.paddle'

function love.load()

   ball = Ball:init()
   
   paddle1 = Paddle.init(love.graphics.getWidth() / 2, 10, "a", "d")
   paddle2 = Paddle.init(love.graphics.getWidth() / 2, love.graphics.getHeight() - 30)
   
   local f = love.graphics.newFont(11)
   love.graphics.setFont(f)
   love.graphics.setBackgroundColor(0,0,0) --,255,255)
end

function love.update(dt)
    ball:update(dt)
    paddle1:update(dt)
    paddle2:update(dt)
end

function love.draw()
    paddle1:draw()
    paddle2:draw()
    ball:draw()
end
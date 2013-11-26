Ball   = require 'entity.ball'
Paddle = require 'entity.paddle'

function love.load()
    paused = false
    gamelost = false
    love.graphics.setMode(640,400, false, true, 4);
   ball = Ball:init()

   player1_score = 0
   player2_score = 0

   background = love.graphics.newImage("img/background.png")

   scoreFont = love.graphics.newFont("font/enhanced_dot_digital-7.ttf", 30)
   largeFont = love.graphics.newFont("font/Gothik Steel.ttf", 54)
   music = love.audio.newSource("snd/music.wav")
   music:setLooping(true)
   love.audio.play(music)
   gameoversnd = love.audio.newSource("snd/game_over.wav", "static")

   paddle1 = Paddle.init(love.graphics.getWidth() / 2, 10, "a", "d", "top")
   paddle2 = Paddle.init(love.graphics.getWidth() / 2, love.graphics.getHeight() - 20)
   
   f = love.graphics.newFont(11)
   love.graphics.setFont(f)
   love.graphics.setBackgroundColor(0,0,0) --,255,255)
end

function love.update(dt)

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
        if(gamelost) then
            reset()
        elseif(paused) then
            paused = false
            love.audio.resume(music)
        else
            paused = true
            love.audio.pause(music)
        end
    end
end

function reset()
    ball = Ball:init()
    ball.x = 20
    ball.y = 50
    paused = false
    gamelost = false
    love.audio.resume(music)
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
    
    -- draw scores
    love.graphics.setFont(scoreFont);
    love.graphics.print(player1_score, 5,5)
    love.graphics.print(player2_score, love.graphics.getWidth() - (scoreFont:getWidth(player2_score) + 5), love.graphics.getHeight() - (scoreFont:getHeight() + 5))
    
    if(paused) then
        love.graphics.setFont(largeFont);
        love.graphics.print("PAUSED", (love.graphics.getWidth() / 2) - (largeFont:getWidth("PAUSED") / 2), (love.graphics.getHeight() / 2) - (largeFont:getHeight() / 2))
        love.graphics.setFont(f);
    end

    if(gamelost) then
        love.audio.pause(music)
        love.graphics.setFont(largeFont);
        love.graphics.print("GAME OVER", (love.graphics.getWidth() / 2) - (largeFont:getWidth("GAME OVER") / 2), (love.graphics.getHeight() / 2) - (largeFont:getHeight() / 2))
        love.graphics.setFont(f);
    end
end
Ball   = require 'entity.ball'
Paddle = require 'entity.paddle'

function love.load()
    paused = false
    gamelost = false
    love.graphics.setMode(640,400, false, true, 4);
   ball = Ball:init()

   last_update = 0
   last_dir    = "left"

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

    last_update = last_update + dt
    if(gamelost == false and paused == false) then

        --invincible ai
        local mid = (ball.x + (ball.radius / 2)) - (paddle1.width / 2);
        --math.randomseed(dt)
        --math.randomseed(ball.x + ball.y)
        go = math.random(0,1000)

        if(last_update > 0.3) then
            last_update = 0
                if(mid < paddle1.x) then
                    paddle1:moveLeft(dt)
                    last_dir = "left"
                else
                    paddle1:moveRight(dt)
                    last_dir = "right"
                end
        else
            if(go > 100) then
                if(last_dir == "left") then
                    paddle1:moveLeft(dt)
                else
                    paddle1:moveRight(dt)
                end
            end
        end

        

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
    ball.x = (love.graphics.getWidth() / 2) - (ball.radius)
    ball.y = (love.graphics.getHeight() / 2) - (ball.radius)
    math.randomseed(os.time() * last_update)
    if(math.random(0,50) > 25) then
        ball.ax = ball.speed
    else
        ball.ax = -ball.speed
    end

    if(math.random(0,50) > 25) then
        ball.ay = ball.speed
    else
        ball.ay = -ball.speed
    end

    paused = false
    gamelost = false
    love.audio.resume(music)
end

function gameover()
    --love.audio.play(gameoversnd)
    --gamelost = true
    reset()
end

function love.draw()
    love.graphics.draw(background)
    ball:draw()
    paddle1:draw()
    paddle2:draw()
    
    -- draw scores
    --love.graphics.print('random = ' .. go, 10, 10)
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
local Paddle = {}

function Paddle.init(x,y, leftKey, rightKey, position)
    local obj = {}
    local pos = position or "bottom"

    obj.x = x or 0 -- 2D x coordinate
    obj.y = y or 10 -- 2D y coordinate

    obj.leftKey  = leftKey or "left"
    obj.rightKey = rightKey or "right"

    obj.height = 12
    obj.width  = 80

    obj.speed = 600

    obj.ax = 1 -- x coordinate acceleration rate
    obj.ay = 1 -- y coodrinate acceleration rate

    obj.f = 0 -- friction amount
    obj.v = 0 -- velocity rate

    obj.color_r = 255
    obj.color_g = 255
    obj.color_b = 255
    obj.color_a = 255

    obj.space = {}

    obj.pad = love.graphics.newImage("img/paddle-" .. pos .. ".png")

    function obj:update(dt)
        
        self.space.top    = self.y
        self.space.bottom = self.y + self.height
        self.space.left   = self.x
        self.space.right  = self.x + self.width

        if(love.keyboard.isDown(self.rightKey)) then
            self.x = self.x + (self.speed * dt)
        end

        if(love.keyboard.isDown(self.leftKey)) then
            self.x = self.x - (self.speed * dt)
        end

        if(self.x + self.width > love.graphics.getWidth()) then
            self.x = love.graphics.getWidth() - self.width
        end

        if(self.x < 0) then
            self.x = 0
        end

        self:check_collisions()
    end

    function obj:moveRight(dt)
        self.x = self.x + (self.speed * dt)
    end

    function obj:moveLeft(dt)
        self.x = self.x - (self.speed * dt)
    end

    function obj:check_collisions()
        if(self:overlap(self.x,self.y,self.width,self.height, ball.x, ball.y , ball.img:getWidth(), ball.img:getHeight())) then
            ball:collision(self)
        end
    end

    function obj:overlap(x1,y1,w1,h1, x2,y2,w2,h2)
        return x1 < x2+w2 and
            x2 < x1+w1 and
            y1 < y2+h2 and
            y2 < y1+h1
    end

    function obj:draw()
        --love.graphics.setColor(255,255,255,255)
        --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        love.graphics.draw(self.pad, self.x, self.y)
    end

    return obj
end

return Paddle
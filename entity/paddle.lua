local Paddle = {}

function Paddle.init(x,y, leftKey, rightKey)
    local obj = {}

    obj.x = x or 0 -- 2D x coordinate
    obj.y = y or 10 -- 2D y coordinate

    obj.leftKey  = leftKey or "left"
    obj.rightKey = rightKey or "right"

    obj.height = 10
    obj.width  = 100

    obj.ax = 1 -- x coordinate acceleration rate
    obj.ay = 1 -- y coodrinate acceleration rate

    obj.f = 0 -- friction amount
    obj.v = 0 -- velocity rate

    obj.color_r = 255
    obj.color_g = 255
    obj.color_b = 255
    obj.color_a = 255

    obj.space = {}

    function obj:update(dt)
        
        self.space.top    = self.y
        self.space.bottom = self.y + self.height
        self.space.left   = self.x
        self.space.right  = self.x + self.width

        if(love.keyboard.isDown(self.rightKey)) then
            self.x = self.x + 5
        end

        if(love.keyboard.isDown(self.leftKey)) then
            self.x = self.x - 5
        end

        self.check_collisions()
    end

    function obj:check_collisions()
    end

    function obj:draw()
        love.graphics.setColor(255,255,255,255)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    end

    return obj
end

return Paddle
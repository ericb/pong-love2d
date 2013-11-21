local Ball = {}

function Ball:init()
    local obj = {}
    obj.x = 0 -- 2D x coordinate
    obj.y = 0 -- 2D y coordinate

    obj.last_x = 0 -- previous 2D x coordinate
    obj.last_y = 0 -- previous 2D y coordinate

    obj.radius    = 5
    obj.segments  = 100

    obj.speed = 300

    obj.ax = obj.speed -- x coordinate acceleration rate
    obj.ay = obj.speed -- y coodrinate acceleration rate

    obj.f = 0 -- friction amount
    obj.v = 0 -- velocity rate

    obj.color_r = 0
    obj.color_g = 255
    obj.color_b = 255
    obj.color_a = 255

    obj.angle = 0 -- travel angle

    function obj:update(dt)
        
        local windowHeight = love.graphics.getHeight()
        local windowWidth  = love.graphics.getWidth()

        self.last_x = self.x
        self.last_y = self.y

        self.x = self.x + (self.ax * dt)
        self.y = self.y + (self.ay * dt)        

        if(self.y + self.radius > windowHeight) then
            if(self.ay > self.speed) then
                self.ay = self.speed
            else
                self.ay = -self.speed
            end
        end

        if(self.y - self.radius < 0) then
            if(self.ay > self.speed) then
                self.ay = -self.speed
            else
                self.ay = self.speed
            end
        end

        if(self.x + self.radius > windowWidth) then
            if(self.ax > self.speed) then
                self.ax = self.speed
            else
                self.ax = -self.speed
            end
        end

        if(self.x - self.radius < 0) then
            if(self.ax > self.speed) then
                self.ax = -self.speed
            else
                self.ax = self.speed
            end
        end

        -- calculate the angle it's currently traveling at
        dx = self.x - self.last_x
        dy = self.y - self.last_y
        self.angle = math.atan2(dy,dx) * 180 / math.pi
    end

    function obj:draw()
        love.graphics.setColor(self.color_r, self.color_g, self.color_b, self.color_a)
        love.graphics.circle("fill", self.x, self.y, self.radius, self.segments)
        
        love.graphics.print('angle = ' .. self.angle, 10, 10)
        love.graphics.print(self.ax .. ', ' .. self.ay, 10, 20)

        --love.graphics.print(self.x, 100, 200)
    end

    return obj

end

return Ball
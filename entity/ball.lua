require 'class'

local Ball = class(function(self, options)
    
    self.x = 0 -- 2D x coordinate
    self.y = 0 -- 2D y coordinate

    self.radius    = 10
    self.segments  = 100

    self.ax = 1 -- x coordinate acceleration rate
    self.ay = 1 -- y coodrinate acceleration rate

    self.f = 0 -- friction amount
    self.v = 0 -- velocity rate

    self.color_r = 255
    self.color_g = 255
    self.color_b = 255
    self.color_a = 255

    _self = self

    function Ball:update(dt)
        _self.x = _self.x + (_self.ax * dt)
        _self.y = _self.y + (_self.ay * dt)

        if(_self.y + 10 >= love.graphics.getHeight()) then
            _self.ay = -300
            _self.ax = -300
        end

        if(_self.y <= 10) then
            _self.ay = 300
            _self.ax = 300
        end
    end

    function Ball:draw()
        love.graphics.setColor(_self.color_r, _self.color_g, _self.color_b, _self.color_a)
        love.graphics.circle("fill", _self.x, _self.y, _self.radius, _self.segments)
    end

end)

return Ball
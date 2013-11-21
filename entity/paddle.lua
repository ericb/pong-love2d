local Paddle = {}

function Paddle:init()
    local obj = {}

    obj.x = 0 -- 2D x coordinate
    obj.y = 0 -- 2D y coordinate

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

    function Paddle.update(dt)

    end

    function Paddle:draw()

    end

    return obj
end
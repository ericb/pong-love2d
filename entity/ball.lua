local Ball = {}

function Ball.init()
    local obj = {}
    obj.x = 0 -- 2D x coordinate
    obj.y = 0 -- 2D y coordinate

    obj.last_x = 0 -- previous 2D x coordinate
    obj.last_y = 0 -- previous 2D y coordinate

    obj.radius    = 6
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
    obj.space = {}

    obj.snd = love.audio.newSource("snd/collision.wav", "static")
    obj.img  = love.graphics.newImage("img/glow.png")
    obj.pong = love.graphics.newImage("img/ball.png")

    obj.effect = love.graphics.newPixelEffect [[
        vec3 rgb = vec3(230/255, 23/255, 255/255);
        vec4 effect(vec4 colour, Image tex, vec2 local, vec2 screen) {
            vec4 c = vec4(1,0,0,1);
            vec4 t = Texel(tex,local);
            vec4 r = mix(c, t, 0);
            r = vec4(rgb.r, rgb.g, rgb.b, t.a);
            
            return r;
        }
    ]]

    obj.system = love.graphics.newParticleSystem( obj.img, 30 )
    obj.system:setPosition( 0, 0 )
    obj.system:setOffset( 0, 0 )
    obj.system:setBufferSize( 1000 )
    obj.system:setEmissionRate( 50 )
    obj.system:setLifetime( -1 )
    obj.system:setParticleLife( 1 )
    --obj.system:setColors( 68, 96, 255, 50, 0, 149, 255, 0 )
    obj.system:setColors( 255, 160, 195, 50, 0, 149, 255, 0 )
    --obj.system:setSizes( 1, 0.15, 0.1 )
    obj.system:setSizes( 1, 0.5, 0.1 )
    obj.system:setSpeed( 30, 30 )
    --obj.system:setDirection( math.rad(90) )
    obj.system:setSpread( math.rad(360) )
    obj.system:setGravity( 0,0 )
    obj.system:setRotation( math.rad(0), math.rad(10) )
    --obj.system:setSpin( math.rad(0.5), math.rad(1), 1 )
    --obj.system:setRadialAcceleration( 0 )
    --obj.system:setTangentialAcceleration( 0 )
    obj.system:start()

    function obj:update(dt)
        
        local windowHeight = love.graphics.getHeight()
        local windowWidth  = love.graphics.getWidth()

        self.last_x = self.x
        self.last_y = self.y

        self.x = self.x + (self.ax * dt)
        self.y = self.y + (self.ay * dt)        

        if(self.y > windowHeight) then
            gameover()
        end

        if(self.y < 0) then
            gameover()
        end

        if(self.x > windowWidth) then
            if(self.ax > self.speed) then
                self.ax = self.speed
            else
                self.ax = -self.speed
            end
            love.audio.play(self.snd)
        end

        if(self.x < 0) then
            if(self.ax > self.speed) then
                self.ax = -self.speed
            else
                self.ax = self.speed
            end
            love.audio.play(self.snd)
        end

        self.system:update(dt)
        self.system:setPosition(self.x,self.y)
        

        self.space.top    = self.y - self.radius
        self.space.bottom = self.y + self.radius
        self.space.left   = self.x - self.radius
        self.space.right  = self.x + self.radius

        -- calculate the angle it's currently traveling at
        dx = self.x - self.last_x
        dy = self.y - self.last_y
        self.angle = math.atan2(dy,dx) * 180 / math.pi

        obj.system:setDirection(self.angle)
    end

    function obj:draw()
        --love.graphics.setColor(self.color_r, self.color_g, self.color_b, self.color_a)

        --love.graphics.setPixelEffect(self.effect)
        --love.graphics.circle("fill", self.x, self.y, self.radius, self.segments)
        
        love.graphics.setPixelEffect()

        love.graphics.setBlendMode("additive")
        love.graphics.draw(self.system, 0, 0)
        love.graphics.setBlendMode("alpha")
        --love.graphics.print('angle = ' .. self.angle, 10, 10)
        --love.graphics.print(self.ax .. ', ' .. self.ay, 10, 20)

        love.graphics.draw(self.pong, self.x, self.y)
    end

    function obj:collision(collider)
        love.audio.rewind(self.snd)
        love.audio.play(self.snd)
        if(self.ay > 0) then
            self.ay = -self.speed
        else
            self.ay = self.speed
        end
        self.y = self.last_y
    end

    return obj

end

return Ball
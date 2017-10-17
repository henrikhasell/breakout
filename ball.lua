Ball = {}

  Ball.metaTable = {}
    Ball.metaTable.__index = Ball

    Ball.speed = 200;
    Ball.radius = 19;

  function Ball:new(x, y)

    local instance = {}
      setmetatable(instance, self.metaTable)

      instance.body = love.physics.newBody(world, x, y, "dynamic")
      instance.shape = love.physics.newCircleShape(19)
      instance.fixture = love.physics.newFixture(instance.body, instance.shape, 1)
      instance.fixture:setRestitution(1)
      instance.body:setLinearVelocity(0, 300)
      instance.dropped = true;

    return instance;
  end

  function Ball:draw()
    local r =  self.shape:getRadius()
    local x =  self.body:getX() - r
    local y =  self.body:getY() - r

    love.graphics.draw(ballImage, x, y, r)
  end

  function Ball:update()
      if self.dropped then
        local x = paddle.body:getX()
        local y = paddle.body:getY() - (paddle.h / 2) - self.radius

        self.body:setX(x)
        self.body:setY(y)

        if love.mouse.isDown(1) then
          self.body:setLinearVelocity(0, -self.speed)
          self.dropped = false
        end
      end
  end

  function Ball:beginContact(a, b, collision)
    local ball

    -- This needs fixing.

    if a.metaTable.__index == Ball then
      ball = a
    else
      ball = b
    end
  end

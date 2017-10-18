Ball = {}

  Ball.metaTable = {}
    Ball.metaTable.__index = Ball

    Ball.speed = 400
    Ball.radius = 19
    Ball.dropped = true

  function Ball:new(x, y)

    local instance = {}
      setmetatable(instance, self.metaTable)

      instance.body = love.physics.newBody(world, x, y, "dynamic")
      instance.shape = love.physics.newCircleShape(instance.radius)
      instance.fixture = love.physics.newFixture(instance.body, instance.shape, 1)
      instance.fixture:setUserData(instance)
      instance.fixture:setRestitution(1)

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
        local y = paddle.body:getY() - (paddle.h / 2)

        self.body:setX(x)
        self.body:setY(y)

        if love.mouse.isDown(1) then
          self.body:setLinearVelocity(0, -self.speed)
          self.dropped = false
        end
      else
        local y = self.body:getY()

        if y > 600 + self.radius then
          self.dropped = true
        end
      end
  end

  function Ball:easeDirection()
    local velocityX, velocityY = self.body:getLinearVelocity()
    local magnitude = math.sqrt(velocityX * velocityX + velocityY * velocityY)
    velocityX = (velocityX / magnitude)
    velocityY = (velocityY / magnitude)
    if math.abs(velocityX) > 0.75 then
      velocityX = velocityX * 0.5
      self.body:setLinearVelocity(velocityX, velocityY)
    end
    self:maintainVelocity()
  end

  function Ball:maintainVelocity()
    local velocityX, velocityY = self.body:getLinearVelocity()
    local magnitude = math.sqrt(velocityX * velocityX + velocityY * velocityY)
    velocityX = (velocityX / magnitude) * self.speed
    velocityY = (velocityY / magnitude) * self.speed
    self.body:setLinearVelocity(velocityX, velocityY)
  end

  function Ball:collisionCallback(object)
    if not self.dropped and getmetatable(object) ~= Paddle.metaTable then
      self:easeDirection()
    end
  end

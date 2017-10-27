Ball = {}

  Ball.metaTable = {}
    Ball.metaTable.__index = Ball

    Ball.balls = {}
    Ball.speed = 400
    Ball.radius = 15

  function Ball:new(x, y)

    local instance = {}
      setmetatable(instance, self.metaTable)

      instance.body = love.physics.newBody(world, x, y, "dynamic")
      instance.shape = love.physics.newCircleShape(instance.radius)
      instance.fixture = love.physics.newFixture(instance.body, instance.shape, 1)
      instance.fixture:setUserData(instance)
      instance.fixture:setFriction(0)
      instance.fixture:setRestitution(1)
      instance.body:setLinearVelocity(0, -instance.speed)
      instance.body:setFixedRotation(true)

      table.insert(Ball.balls, instance)

    return instance;
  end

  function Ball:draw()
    local r =  self.shape:getRadius()
    local x =  self.body:getX() - r
    local y =  self.body:getY() - r
    love.graphics.draw(ballImage, x, y)
  end

  function Ball:update()
    if self.body:getY() > 600 + self.radius then
      self:destroy()
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

  function Ball:destroy()
    for key, value in pairs(Ball.balls) do
      if value == self then
        table.remove(Ball.balls, key)
        break
      end
    end
    if #Ball.balls == 0 then
      lives = lives - 1
      if lives > 0 then
        paddle.hasBall = true
      end
    end
    self.body:destroy()
  end

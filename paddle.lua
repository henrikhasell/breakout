Paddle = {}
  Paddle.metaTable = {}
    Paddle.metaTable.__index = Paddle

  Paddle.w = 188
  Paddle.h = 26

  Paddle.xMax = 800 - Paddle.w / 2
  Paddle.xMin = Paddle.w / 2

  function Paddle:new(x, y)

    local instance = {}
      setmetatable(instance, self.metaTable)

      instance.body = love.physics.newBody(world, x, y, "static")
      instance.shape = love.physics.newRectangleShape(self.w, self.h)
      instance.fixture = love.physics.newFixture(instance.body, instance.shape, 1)
      instance.fixture:setUserData(instance)

    return instance;
  end

  function Paddle:draw()
    local x, y = self.body:getPosition()
    love.graphics.draw(paddleImage, x - self.w / 2, y - self.h / 2)
  end

  function Paddle:updatePosition()
    local x = love.mouse.getPosition()

    if x < self.xMin then
      x = self.xMin
    elseif x > self.xMax then
      x = self.xMax
    end

    self.body:setX(x)
  end

  function Paddle:handleMouseInput()
    if ball.dropped and love.mouse.isDown(1) then
      ball.body:setLinearVelocity(0, ball.speed)
      ball.dropped = false
    end
  end

  function Paddle:update()
    self:updatePosition()
  end

  function Paddle:collisionCallback(object)
    if getmetatable(object) == Ball.metaTable then
      local objectX = object.body:getPosition()
      local paddleX = self.body:getPosition()
      local xVelocity = (objectX - paddleX) / self.w
      local yVelocity = -2

      local magnitude = math.sqrt(xVelocity * xVelocity + yVelocity * yVelocity)
      xVelocity = (xVelocity / magnitude) * object.speed
      yVelocity = (yVelocity / magnitude) * object.speed

      object.body:setLinearVelocity(xVelocity, yVelocity)
    end
  end

Paddle = {}
  Paddle.metaTable = {}
    Paddle.metaTable.__index = Paddle

  Paddle.w = 188
  Paddle.h = 26

  Paddle.xMax = 800 - Paddle.w / 2
  Paddle.xMin = Paddle.w / 2

  Paddle.hasBall = true

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
    local w2 = self.w / 2
    local h2 = self.h / 2
    if self.hasBall then
        local ballX = x - Ball.radius
        local ballY = y - Ball.radius * 2 - h2
        love.graphics.draw(ballImage, ballX, ballY)
    end
    love.graphics.draw(paddleImage, x - w2, y - h2)
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

  function Paddle:createBall()
      local x, y = self.body:getPosition()
      local ballX = x - Ball.radius
      local ballY = y - Ball.radius * 2 - self.h / 2
      local ball = Ball:new(x, y)
  end

  function Paddle:handleMouseInput()
    if self.hasBall and love.mouse.isDown(1) then
      self.hasBall = false
      self:createBall()
    end
  end

  function Paddle:update()
    self:updatePosition()
    self:handleMouseInput()
  end

  function Paddle:collisionCallback(object)
    -- Have we collided with a ball?
    if getmetatable(object) == Ball.metaTable then
      -- Fetch the position of the ball and the paddle.
      local objectX, objectY = object.body:getPosition()
      local paddleX, paddleY = self.body:getPosition()
      -- Make sure the ball is not touching the bottom of the paddle.
      if objectY < paddleY - self.h / 2 then
        -- Calculate the directional vector to apply to the ball.
        local xVelocity = (objectX - paddleX) / self.w
        local yVelocity = -2
        -- Set the ball's velocity.
        object.body:setLinearVelocity(xVelocity, yVelocity)
        object:maintainVelocity()
      end
    end
  end

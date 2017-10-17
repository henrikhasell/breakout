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
      instance.shape = love.physics.newRectangleShape(0, 0, self.w, self.h)
      instance.fixture = love.physics.newFixture(instance.body, instance.shape, 1)
      instance.fixture:setRestitution(1)

    return instance;
  end

  function Paddle:draw()
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
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
      ball.body:setLinearVelocity(0, 200)
      ball.dropped = false
    end
  end

  function Paddle:update()
    self:updatePosition()
  end

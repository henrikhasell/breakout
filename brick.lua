Brick = {}
  Brick.metaTable = {}
    Brick.metaTable.__index = Brick

  Brick.w = 80
  Brick.h = 30

  Brick.bricks = {}

  function Brick:new(x, y, r, g, b)

    local instance = {}
      setmetatable(instance, self.metaTable)

      instance.body = love.physics.newBody(world, x, y, "static")
      instance.shape = love.physics.newRectangleShape(self.w / 2, self.h / 2, self.w, self.h)
      instance.fixture = love.physics.newFixture(instance.body, instance.shape, 1)
      instance.fixture:setUserData(instance)
      instance.colour = {r, g, b}

    table.insert(Brick.bricks, instance)
    instance.index = table.getn(Brick.bricks)

    return instance;
  end

  function Brick:draw()
    local x, y = self.body:getPosition()
    love.graphics.setColor(self.colour[1], self.colour[2], self.colour[3], 0xff)
    love.graphics.draw(brickImage, x, y)
  end

  function Brick:collisionCallback()
    self:destroy()
  end

  function Brick:destroy()
    for key, value in pairs(Brick.bricks) do
      if value == self then
        table.remove(Brick.bricks, key)
        break
      end
    end
    self.body:destroy()
  end

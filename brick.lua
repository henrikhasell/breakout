Brick = {}
  Brick.metaTable = {}
    Brick.metaTable.__index = Brick

  Brick.w = 80
  Brick.h = 30

  Brick.bricks = {}

  function Brick:new(x, y)

    local instance = {}
      setmetatable(instance, self.metaTable)

      instance.body = love.physics.newBody(world, x, y, "static")
      instance.shape = love.physics.newRectangleShape(self.w / 2, self.h / 2, self.w, self.h)
      instance.fixture = love.physics.newFixture(instance.body, instance.shape, 1)
      instance.fixture:setUserData(instance)

    table.insert(Brick.bricks, instance)
    instance.index = table.getn(Brick.bricks)

    return instance;
  end

  function Brick:draw()
    local x, y = self.body:getPosition()
    love.graphics.draw(brickImage, x, y)
  end

  function Brick:collisionCallback()
    self:remove()
  end

  function Brick:remove()
    for key, value in pairs(Brick.bricks) do
      if value == self then
        table.remove(Brick.bricks, key)
        self.body:destroy()
      end
    end
  end

Bounds = {}

  Bounds.metaTable = {}
    Bounds.metaTable.__index = Bounds

function Bounds:new(x, y)

  local instance = {}
    setmetatable(instance, self.metaTable)

    instance.body = love.physics.newBody(world, 0, 0, "static")

    instance.left = {}
    instance.left.shape = love.physics.newRectangleShape(5, 300, 10, 600)
    instance.left.fixture = love.physics.newFixture(instance.body, instance.left.shape)

    instance.right = {}
    instance.right.shape = love.physics.newRectangleShape(795, 300, 10, 600)
    instance.right.fixture = love.physics.newFixture(instance.body, instance.right.shape)

    instance.top = {}
    instance.top.shape = love.physics.newRectangleShape(400, 5, 780, 10)
    instance.top.fixture = love.physics.newFixture(instance.body, instance.top.shape)

  return instance
end

function Bounds:draw()
  love.graphics.polygon("line", self.body:getWorldPoints(self.left.shape:getPoints()))
  love.graphics.polygon("line", self.body:getWorldPoints(self.right.shape:getPoints()))
  love.graphics.polygon("line", self.body:getWorldPoints(self.top.shape:getPoints()))
end

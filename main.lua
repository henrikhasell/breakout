require("ball")
require("bounds")
require("paddle")
require("brick")

log = ""

function collisionCallback(fixture1, fixture2, collision)
  local object1 = fixture1:getUserData()
  local object2 = fixture2:getUserData()
  object1:collisionCallback(object2)
  object2:collisionCallback(object1)
end

function love.load()
  backgroundImage = love.graphics.newImage("Assets/Background.png")
  paddleImage = love.graphics.newImage("Assets/Paddle.png")
  ballImage = love.graphics.newImage("Assets/Ball.png")

  world = love.physics.newWorld(0, 0, true)
  world:setCallbacks(nil, nil, nil, collisionCallback)

  ball = Ball:new(400, 300)
  bounds = Bounds:new(0, 0)
  paddle = Paddle:new(400, 550);

  for i=0,10 do
    for j=0,3 do
      local colour
      if j == 0 then
        colour = Brick.red
      end
      if j == 1 then
        colour = Brick.green
      end
      if j == 2 then
        colour = Brick.blue
      end
      if j == 3 then
        colour = Brick.white
      end
      Brick:new(Brick.w * i, Brick.h * j, colour)
    end
  end
end

function love.update(dt)
    paddle:update()
    ball:update()
    world:update(dt)
end

function love.draw()
  love.graphics.draw(backgroundImage)
  paddle:draw()
  ball:draw()

  for k,v in pairs(Brick.bricks) do
    v:draw()
  end

  love.graphics.print(log)
end

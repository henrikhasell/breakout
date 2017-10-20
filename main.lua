require("ball")
require("bounds")
require("paddle")
require("brick")

function collisionCallback(fixture1, fixture2, collision)
  local object1 = fixture1:getUserData()
  local object2 = fixture2:getUserData()
  object1:collisionCallback(object2)
  object2:collisionCallback(object1)
end

function love.load()
  backgroundImage = love.graphics.newImage("Assets/Background.png")
  paddleImage = love.graphics.newImage("Assets/Paddle.png")
  brickImage = love.graphics.newImage("Assets/Brick.png")
  ballImage = love.graphics.newImage("Assets/Ball.png")

  world = love.physics.newWorld(0, 0, true)
  world:setCallbacks(nil, nil, nil, collisionCallback)

  bounds = Bounds:new(0, 0)
  paddle = Paddle:new(400, 550);

  for i=0,9 do
    for j=0,5 do
      local colour
          if j == 0 then colour = {0xc8, 0x48, 0x48}
      elseif j == 1 then colour = {0xc6, 0x6c, 0x3a}
      elseif j == 2 then colour = {0xb4, 0x7a, 0x30}
      elseif j == 3 then colour = {0xa2, 0xa2, 0x2a}
      elseif j == 4 then colour = {0x48, 0xa0, 0x48}
      elseif j == 5 then colour = {0x42, 0x48, 0xc8} end
      Brick:new(Brick.w * i, Brick.h * (4 + j), colour[1], colour[2], colour[3])
    end
  end
end

function love.update(dt)
    paddle:update()
    for k,v in pairs(Ball.balls) do
      v:update()
    end
    world:update(dt)
end

function love.draw()
  love.graphics.draw(backgroundImage)
  paddle:draw()

  for k,v in pairs(Brick.bricks) do
    v:draw()
  end

  love.graphics.setColor(0xff,  0xff,  0xff, 0xff)

  for k,v in pairs(Ball.balls) do
    v:draw()
  end
end

require("ball")
require("bounds")
require("paddle")

function love.load()
  backgroundImage = love.graphics.newImage("Assets/Background.png")
  paddleImage = love.graphics.newImage("Assets/Paddle.png")
  ballImage = love.graphics.newImage("Assets/Ball.png")

  world = love.physics.newWorld(0, 0, true)
  ball = Ball:new(400, 300)
  bounds = Bounds:new(0, 0)
  paddle = Paddle:new(400, 550);
end

function love.update(dt)
    paddle:update()
    ball:update()
    world:update(dt)
end

function love.draw()
  love.graphics.draw(backgroundImage)
  bounds:draw()
  ball:draw()
  paddle:draw()
end

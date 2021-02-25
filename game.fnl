(local player {"x" 0 "y" 0 "speed" 100 "image" nil})

(fn draw-player []
  (love.graphics.draw (. player "image") (. player "x") (. player "y")))

(fn love.load []
  (tset player "image" (love.graphics.newImage "assets/player.png")))

(fn love.draw []
  (draw-player))

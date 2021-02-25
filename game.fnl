(local player {"x" 300 "y" 300 "speed" 100 "image" nil})

(fn try-move [dt]
  (if (love.keyboard.isDown "a")
      (when (> (. player "x") 0)
        (tset player "x" (- (. player "x") (* (. player "speed") dt))))
      (love.keyboard.isDown "d")
      (when (< (. player "x") (- (love.graphics.getWidth) (player.image:getWidth)))
        (tset player "x" (+ (. player "x") (* (. player "speed") dt))))
      (love.keyboard.isDown "w")
      (when (> (. player "y") 0)
        (tset player "y" (- (. player "y") (* (. player "speed") dt))))
      (love.keyboard.isDown "s")
      (when (< (. player "y") (- (love.graphics.getHeight) (player.image:getHeight)))
        (tset player "y" (+ (. player "y") (* (. player "speed") dt))))))

(fn draw-player []
  (love.graphics.draw (. player "image") (. player "x") (. player "y")))

(fn love.load []
  (tset player "image" (love.graphics.newImage "assets/player.png")))

(fn love.update [dt]
  (try-move dt))

(fn love.draw []
  (draw-player))

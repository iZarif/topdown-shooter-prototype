(local anim8 (require "lib.anim8"))

(local player {"w" 69 "h" 71 "x" 300 "y" 300 "speed" 100 "anims" {}})
(var spritesheet nil)

(fn update-player [player dt]
  (if (love.keyboard.isDown "a")
      (when (> player.x 0)
        (tset player "x" (- player.x (* player.speed dt))))
      (love.keyboard.isDown "d")
      (when (< player.x (- (love.graphics.getWidth) player.w))
        (tset player "x" (+ player.x (* player.speed dt))))
      (love.keyboard.isDown "w")
      (when (> player.y 0)
        (tset player "y" (- player.y (* player.speed dt))))
      (love.keyboard.isDown "s")
      (when (< player.y (- (love.graphics.getHeight) player.h))
        (tset player "y" (+ player.y (* player.speed dt)))))

  (player.anim:update dt))

(fn draw-player [player]
  (player.anim:draw spritesheet player.x player.y))

(fn love.load []
  (set spritesheet (love.graphics.newImage "assets/spritesheet.png"))
  (let [anim-grid (anim8.newGrid player.w player.h (spritesheet:getWidth) (spritesheet:getHeight) 0 0 1)]
    (tset player.anims "run-forward" (anim8.newAnimation (anim-grid "2-5" 1) 0.2)))
  (tset player "anim" player.anims.run-forward))

(fn love.update [dt]
  (update-player player dt))

(fn love.draw []
  (draw-player player))

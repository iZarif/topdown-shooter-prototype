(local player {"w" 10 "h" 11 "x" 300 "y" 300 "speed" 100 "anims" {}})

(fn make-anim [image width height duration]
  (let [anim {"spritesheet" image "curr-time" 0 "quads" {} "sprite-num" 1}]
    (for [y 0 (- (image:getHeight) height) height]
      (for [x 0 (- (image:getWidth) width) width]
        (table.insert anim.quads (love.graphics.newQuad x y width height (image:getDimensions)))))
    (tset anim "duration" (or duration 1))
    anim))

(fn update-anim [anim dt]
  (tset anim "curr-time" (+ anim.curr-time dt))
  (if (>= anim.curr-time anim.duration)
      (tset anim "curr-time" (- anim.curr-time anim.duration)))
  (tset anim "sprite-num" (+ (math.floor (* (/ anim.curr-time anim.duration) (length anim.quads))) 1)))

(fn update-player [player dt]
  (if (love.keyboard.isDown "a")
      (when (> player.x 0)
        (tset player "x" (- player.x (* player.speed dt))))
      (love.keyboard.isDown "d")
      (when (< player.x (- (love.graphics.getWidth) player.w))
        (tset player "x" (+ player.x (* player.speed dt))))
      (love.keyboard.isDown "w")
      (when (> player.y 0)
        (tset player "y" (- player.y (* player.speed dt)))
        (update-anim player.anim dt))
      (love.keyboard.isDown "s")
      (when (< player.y (- (love.graphics.getHeight) player.h))
        (tset player "y" (+ player.y (* player.speed dt))))))

(fn draw-player [player]
  (love.graphics.draw player.anim.spritesheet (. player.anim.quads player.anim.sprite-num) player.x player.y))

(fn love.load []
  (tset player.anims "run-forward" (make-anim (love.graphics.newImage "assets/player-run-forward.png") player.w player.h 1))
  (tset player "anim" player.anims.run-forward))

(fn love.update [dt]
  (update-player player dt))

(fn love.draw []
  (draw-player player))

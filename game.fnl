(local anim8 (require "lib.anim8"))

(var spritesheet nil)
(var player nil)

(fn make-player []
  (let [player {"w" 69 "h" 71 "x" 300 "y" 300 "speed" 100 "anims" {} "facing" "forward"}
        anim-grid (anim8.newGrid player.w player.h (spritesheet:getWidth) (spritesheet:getHeight) 0 0 1)]
    (tset player.anims "stand-forward" (anim8.newAnimation (anim-grid 1 1) 1))
    (tset player.anims "stand-backward" (player.anims.stand-forward.flipV (player.anims.stand-forward:clone)))
    (tset player.anims "run-forward" (anim8.newAnimation (anim-grid "2-5" 1) 0.2))
    (tset player "anim" player.anims.stand-forward)
    player))

(fn update-player [player dt]
    (if (= player.facing "forward")
          (tset player "anim" player.anims.stand-forward)
          (= player.facing "left")
          (tset player "anim" player.anims.stand-left)
          (= player.facing "backward")
          (tset player "anim" player.anims.stand-backward)
          (= player.facing "right")
          (tset player "anim" player.anims.stand-right))
  
  (if (love.keyboard.isDown "a")
      (when (> player.x 0)
        (tset player "facing" "left")
        (tset player "x" (- player.x (* player.speed dt))))
      (love.keyboard.isDown "d")
      (when (< player.x (- (love.graphics.getWidth) player.w))
        (tset player "facing" "right")
        (tset player "x" (+ player.x (* player.speed dt))))
      (love.keyboard.isDown "w")
      (when (> player.y 0)
        (tset player "facing" "forward")
        (tset player "y" (- player.y (* player.speed dt))))
      (love.keyboard.isDown "s")
      (when (< player.y (- (love.graphics.getHeight) player.h))
        (tset player "facing" "backward") 
        (tset player "y" (+ player.y (* player.speed dt)))))   

  (player.anim:update dt))

(fn draw-player [player]
  (player.anim:draw spritesheet player.x player.y))

(fn love.load []
  (set spritesheet (love.graphics.newImage "assets/spritesheet.png"))
  (set player (make-player)))

(fn love.update [dt]
  (update-player player dt))

(fn love.draw []
  (love.graphics.setBackgroundColor 1 1 1 0)
  (draw-player player))

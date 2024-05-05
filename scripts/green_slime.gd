extends Node2D

const SPEED = 60

#Right is 1, left is -1
var direction = 1

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
#If there are not many frames, delta is big, so by multiplying this value, the sprite is not moving too fast or too slow
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1 #Change the direction to left if it's going to collide
		animated_sprite.flip_h = true
		
	if ray_cast_left.is_colliding():
		direction = 1	
		animated_sprite.flip_h = false
		
	position.x += direction * SPEED * delta

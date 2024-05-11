extends Node2D

var SPEED = 60

#Right is 1, left is -1
var direction = 1

@onready var ray_cast_left = $RayCast2DLeft
@onready var ray_cast_right = $RayCast2DRight
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
	
	#When the player attacks the monster
	if animated_sprite.animation == "attacked":
		SPEED = -30 #Slow the monster down
		direction = direction * -1 #Move the monster the opposite way
		await get_tree().create_timer(0.4).timeout #For the attacked animation
		queue_free() #Monster disappear


func _on_kill_zone_damaged_enemy(status):
	print(status) #Printing value sent over by signal emitter to check if the signal is connected.
	animated_sprite.play("attacked")

extends Node2D

var SPEED = 60

#Right is 1, left is -1
var direction = 1

@onready var ray_cast_2d_right = $RayCast2D_Right
@onready var ray_cast_2d_left = $RayCast2D_Left
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_2d_right.is_colliding():
		direction = -1 #Change the direction to left if it's going to collide
		animated_sprite.flip_h = false
		
	if ray_cast_2d_left.is_colliding():
		direction = 1	
		animated_sprite.flip_h = true
		
	position.x += direction * SPEED * delta
	
	#When the player attacks the enemy
	if animated_sprite.animation == "attacked":
		SPEED = -30 #Slow the monster down
		direction = direction * -1 #Move the monster the opposite way
		await get_tree().create_timer(0.4).timeout #For the attacked animation
		queue_free() #Monster disappear


func _on_kill_zone_damaged_enemy(status):
	print(status) #Printing value sent over by signal emitter to check if the signal is connected.
	animated_sprite.play("attacked")

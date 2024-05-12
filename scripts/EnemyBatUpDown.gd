extends Node2D

var SPEED = 60

#Right is 1, left is -1
var direction = 1

@onready var ray_cast_2d_up = $RayCast2DUp
@onready var ray_cast_2d_down = $RayCast2DDown
@onready var animated_sprite = $AnimatedSprite2D

#Method 1 of emitting signal
signal killed_enemy(name, position)

#Getting the initial position of the enemy placed. 
#Will reflect respective positions for each enemy node the kill_zone is attached to.
@onready var enemy_pos = get_node(".").global_position
@onready var enemy_name = get_node(".").name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_2d_up.is_colliding():
		direction = 1 #Change the direction to left if it's going to collide
		#animated_sprite.flip_h = false
		
	if ray_cast_2d_down.is_colliding():
		direction = -1	
		#animated_sprite.flip_h = true
		
	position.y += direction * SPEED * delta
	
	#When the player attacks the monster
	if animated_sprite.animation == "attacked":
		SPEED = -30 #Slow the monster down
		direction = direction * -1 #Move the monster the opposite way
		await get_tree().create_timer(0.4).timeout #For the attacked animation
		queue_free() #Monster disappear
		killed_enemy.emit(enemy_name, enemy_pos)


func _on_kill_zone_damaged_enemy(status):
	print(status) #Printing value sent over by signal emitter to check if the signal is connected.
	animated_sprite.play("attacked")

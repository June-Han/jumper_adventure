extends Node2D

var SPEED = 60

#Right is 1, left is -1
var direction = 1
@onready var ray_cast_left = $RayCast2DLeft
@onready var ray_cast_right = $RayCast2DRight
@onready var animated_sprite = $AnimatedSprite2D


#Method 1 of emitting signal
signal killed_enemy(name, position)

#Getting the initial position of the enemy placed. 
#Will reflect respective positions for each enemy node the kill_zone is attached to.
@onready var enemy_pos = get_node(".").global_position
@onready var enemy_name = get_node(".").name

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1 #Change the direction to left if it's going to collide
		animated_sprite.flip_h = true
		
	if ray_cast_left.is_colliding():
		direction = 1	
		animated_sprite.flip_h = false
		
	position.x += direction * SPEED * delta

	#When the player attacks the enemy
	if animated_sprite.animation == "attacked":
		SPEED = -30 #Slow the monster down
		direction = direction * -1 #Move the monster the opposite way
		await get_tree().create_timer(0.4).timeout #For the attacked animation
		queue_free() #Monster disappear
		killed_enemy.emit(enemy_name, enemy_pos)

#Connecting the signal emitted from the kill_zone through node in the UI
func _on_kill_zone_damaged_enemy(status):
	print("status")
	animated_sprite.play("attacked")

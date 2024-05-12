extends Node2D

var SPEED = 60

#Right is 1, left is -1
var direction = 1

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var animated_sprite = $AnimatedSprite2D

#Method 2 of emitting signal
signal killed_enemy

#Getting the initial position of the enemy placed. 
#Will reflect respective positions for each enemy node the kill_zone is attached to.
@onready var enemy_pos = get_node(".").global_position
@onready var enemy_name = get_node(".").name

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

	#When the player attacks the enemy
	if animated_sprite.animation == "attacked":
		SPEED = -30 #Slow the monster down
		direction = direction * -1 #Move the monster the opposite way
		await get_tree().create_timer(0.4).timeout #For the attacked animation
		queue_free() #Monster disappear
		
		#Will print out the respective positions for each enemy node the kill_zone is attached to.
		print("Global position of enemy from kill_zone" + str(enemy_pos)) 
		#Print out enemy name
		print("Enemy name is " + str(enemy_name))
		#Emitting some signals
		emit_signal("killed_enemy", enemy_name, enemy_pos)
		print("Emitting Signal Done")

#Connect the damaged_enemy signal from the kill_zone node to the function in this scene (on_killed_zone_damaged_enemy)
#Already connected from the node Inspector UI, hence this function is not necessary 
#func _ready() function is similar to @onready at the top
#func _ready():
	#get_node("kill_zone").damaged_enemy.connect(_on_kill_zone_damaged_enemy)
	
func _on_kill_zone_damaged_enemy(value):
	print(value) #Printing value sent over by signal emitter to check if the signal is connected.
	animated_sprite.play("attacked")

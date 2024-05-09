extends Node2D

var SPEED = 60

#Right is 1, left is -1
var direction = 1

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var animated_sprite = $AnimatedSprite2D
signal damaged_enemy

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

	if animated_sprite.animation == "attacked":
		SPEED = -30 #Monster move opposite way
		#Engine.time_scale = 0.8 #Slow down
		await get_tree().create_timer(0.4).timeout #For the attacked animation
		#Engine.time_scale = 1
		queue_free() #Monster disappear

#Connect the damaged_enemy signal from the kill_zone node to the function in this scene (on_killed_zone_damaged_enemy)
func _ready():
	get_node("kill_zone").damaged_enemy.connect(_on_kill_zone_damaged_enemy)
	
func _on_kill_zone_damaged_enemy(value):
	print(value) #Printing value sent over by signal emitter to check if the signal is connected.
	animated_sprite.play("attacked")

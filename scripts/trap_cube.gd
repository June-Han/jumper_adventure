extends Node2D

var SPEED = 60
@onready var animated_sprite = $AnimatedSprite2D

#Method 1 of emitting signal
signal killed_enemy(name, position)

#Getting the initial position of the enemy placed. 
#Will reflect respective positions for each enemy node the kill_zone is attached to.
@onready var enemy_pos = get_node(".").global_position
@onready var enemy_name = get_node(".").name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#When the player attacks the enemy
	if animated_sprite.animation == "attacked":
		await get_tree().create_timer(0.4).timeout #For the attacked animation
		queue_free() #Monster disappear
		killed_enemy.emit(enemy_name, enemy_pos)


func _on_kill_zone_damaged_enemy(status):
	print(status) #Printing value sent over by signal emitter to check if the signal is connected.
	animated_sprite.play("attacked")

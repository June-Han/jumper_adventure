extends Node2D

var SPEED = 60
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#When the player attacks the enemy
	if animated_sprite.animation == "attacked":
		await get_tree().create_timer(0.4).timeout #For the attacked animation
		queue_free() #Monster disappear


func _on_kill_zone_damaged_enemy(status):
	print(status) #Printing value sent over by signal emitter to check if the signal is connected.
	animated_sprite.play("attacked")

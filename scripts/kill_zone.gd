extends Area2D
#IMPORTANT!
#Player is on Collision Layer 2, the monsters are on collision layer 2. Layer 2 is made solely for monster interactions!
#Creating a variable to reference the timer node to start the timer from the code (Drag the node, click ctrl before dropping)
@onready var timer = $Timer
@onready var animated_enemy = $"../AnimatedSprite2D"
#signal damaged_enemy(value)

# Called when the physics body/character enter the kill zone area marked by the world boundary shape
#phyiscs body/character is represented by variable body
func _on_body_entered(body):
	print("Game Over")
	Engine.time_scale = 0.5
	#Remove the collision shape from player (body enters kill zone is player) and the player falls off the map
	body.get_node("CrouchCollisionShape2D").queue_free()
	timer.start()
	
#Running when timer ends
func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene() #Get the scene tree and reload current scene. (Return to the start of the map)

#When the sword reaches the monster kill zone. 
#area is the area input from the player
func _on_area_entered(area):
	if area.is_in_group("Sword"):
		animated_enemy.play("attacked")
		queue_free() #Free the collisiona area for the kill zone

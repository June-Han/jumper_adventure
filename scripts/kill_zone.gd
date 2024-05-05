extends Area2D

#Creating a variable to reference the timer node to start the timer from the code (Drag the node, click ctrl before dropping)
@onready var timer = $Timer

# Called when the physics body/character enter the kill zone area marked by the world boundary shape
func _on_body_entered(body):
	print("Game Over")
	Engine.time_scale = 0.5
	#Remove the collision shape from player (body enters kill zone is player) and the player falls off the map
	body.get_node("CollisionShape2D").queue_free() 
	timer.start()
	

#Running when timer ends
func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene() #Get the scene tree and reload current scene. (Return to the start of the map)

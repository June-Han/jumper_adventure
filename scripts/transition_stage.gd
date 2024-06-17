extends Area2D

signal transition_scene(player_pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_body_entered(body):
	if body.is_in_group("player"):
		#if the player entered the collision area
		transition_scene.emit(body.global_position)
		print("emitting signal due to transition to next stage done")
		
	
func _on_body_exited(body):
	pass

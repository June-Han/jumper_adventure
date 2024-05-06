extends Area2D

#Able to access the manager only on the same scene.
#If on the different scene it doesn't work
@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

# Called when the physics body/character enter the area of the coin
# Coin is on collision layer 1 and the player is set on collision layer 2.
# Set the mask on coin on mask 2 to detect the change only from layer 2 which is the player. 
# (This is the layer method. Code can be used to specify as well)
func _on_body_entered(body):
	game_manager.addPoint()
	#queue_free() #Remove the entire coin from scene after picking it up
	#Queue_free is replaced with animation player to add in the animation and sound
	animation_player.play("pickupAnimation")

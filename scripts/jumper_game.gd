extends Node2D


@onready var prev_stage_pos = 0
@onready var current_scene = "jumper_game"

func _on_killed_enemy(enemy_name, enemy_pos):
	print("Let's respawn some enemies")
	await get_tree().create_timer(1).timeout
	
	#Loading Enemy Scene
	#Remove the numbers to access the original scene object to respawn
	var enemy_scene_name = str(enemy_name).rstrip("0123456789") 
	var enemy = load("res://scenes/"+ str(enemy_scene_name) + ".tscn")
	
	#Instanting a new enemy object and rename the object to original name
	var new_enemy = enemy.instantiate()
	new_enemy.name = enemy_name #Otherwise the name of the node will have @Node2D or @Node2D@2          
	
	#Respawn back at original global position
	new_enemy.global_position = enemy_pos
	
	#Signals within the enemy object itself will be instantiated. 
	#But the signal from the instantiated object received by functions 
	#outside of object need to be connected by code outside of the object before adding it as child
	new_enemy.killed_enemy.connect(_on_killed_enemy) #Connecting the killed_enemy signal within the instantiated object to this function (Only this signal is not instantiated)
	add_child(new_enemy)


func _on_transition_scene(player_pos):
	print(player_pos)
	prev_stage_pos = player_pos
	if current_scene == "jumper_game":
		get_tree().change_scene_to_file("res://scenes/jumper_stage_2.tscn")
		current_scene = "jumper_stage_2"
	# print(get_tree().get_current_scene()) #JumperGame:<Node2D#136818198380>
	# print(get_tree().get_current_scene().name) #JumperGame
	# print(get_node(".").name) #JumperGame

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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

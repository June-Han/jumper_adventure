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
	var enemy = load("res://scenes/"+ str(enemy_name) + ".tscn")
	var new_enemy = enemy.instantiate()
	new_enemy.global_position = enemy_pos
	add_child(new_enemy)

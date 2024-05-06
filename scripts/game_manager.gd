extends Node

var score = 0

@onready var score_label = $ScoreLabel

#This game manager is to be accessed as a unique name 
#(Right click and after selecting unique name, % sign will be shown)
func addPoint():
	score += 1
	score_label.text = "You Collected " + str(score) + " coins."

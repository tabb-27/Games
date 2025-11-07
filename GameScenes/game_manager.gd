extends Node

var points = 0
var lives = 3

@onready var label: Label = $"../CanvasLayer/Panel/Label"
@export var hearts : Array[Node]

func add_point():
	points += 1
	print(points)
	label.text = "POINTS :" + str(points)
	
func get_point():
	return points
	
func decrease_health():
	lives-=1
	
	for h in 3:
		if (h<lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	
	if (lives == 0):
		get_tree().reload_current_scene()

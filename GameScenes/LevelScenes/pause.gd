extends Node

@onready var panel: Panel = $Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var esc_pressed = Input.is_action_just_pressed("escape")
	if esc_pressed:
		panel.visible = true
		get_tree().paused = true


func _on_resume_button_pressed() -> void:
	print("RESUME")
	get_tree().paused = false
	panel.visible = false
	
func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://GameScenes/MenuScenes/main_menu.tscn")

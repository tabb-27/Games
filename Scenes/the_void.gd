extends Area2D

@export var target_scene : PackedScene

@export var spawn_x : int 
@export var spawn_y : int
@onready var game_manager: Node = %GameManager

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:

	if body is CharacterBody2D:
		game_manager.decrease_health()
		body.position.x = spawn_x
		body.position.y = spawn_y

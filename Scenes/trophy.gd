extends Area2D

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var target_level : PackedScene
@onready var game_manager: Node = %GameManager
@onready var collectible_group: Node2D = $"../CollectibleGroup"

var point

#var point = collectible_group.get_child_count()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.animation = "default"
	point = collectible_group.get_child_count()
	print("POINT IS :")
	print(point)

func _on_body_entered(body: Node2D) -> void:
	print("POINT")
	print(point)
	print("POINT")
	
	if body is CharacterBody2D and game_manager.get_point() >= point:

		sprite_2d.play("pop")
	
		await sprite_2d.animation_finished
		
		get_tree().change_scene_to_packed(target_level)
	

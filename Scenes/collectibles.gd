extends Area2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var game_manager: Node = $"../../../GameManager"

var base_y = 0.0
var time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.animation = "default"
	base_y = position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * 7.0
	position.y = base_y + sin(time) * 3
	

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("Player"):
		print("COLLECTED")
		sprite_2d.play("collect")
		
		await sprite_2d.animation_finished
		body.spawn_particle(position)
		
		queue_free()
		game_manager.add_point()

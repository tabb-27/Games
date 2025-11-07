extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var time = 0
var stun = false 
var facingLeft = false

@onready var game_manager: Node = %GameManager

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var speed : float

func _physics_process(delta: float) -> void:
	time += delta*2
	if stun == false:
		velocity.x = sin(time) * speed
	else:
		velocity.x = 0
	
	sprite_2d.flip_h = velocity.x > 0
		
	move_and_slide()
	
func die():
	sprite_2d.play("hit")
	stun = true
	
	game_manager.add_point()
		
	await sprite_2d.animation_finished
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:

	if body.is_in_group("Player") and stun == false:
		body.velocity.y = -500

		game_manager.decrease_health()
	

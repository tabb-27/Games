extends Area2D

@onready var tram_sprite: AnimatedSprite2D = $AnimatedSprite2D

const BOUNCE_VELOCITY = 1500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tram_sprite.animation = "default"


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		
		#GET BOUNCE DIRECTION BASED ON TRAMPOLINE ROTATION
		var bounce_dir = Vector2.UP.rotated(rotation)
		print(rotation)
		print(rotation_degrees)
		print(bounce_dir)
		
		#APPLY BOUNCE
		body.velocity = Vector2.ZERO
		body.velocity = bounce_dir * BOUNCE_VELOCITY
		
		#PLAY BOUNCE ANIMATION
		tram_sprite.play("bounce") 
		
		#WAIT FOR ANIMATION TO FINISH
		await tram_sprite.animation_finished
		tram_sprite.play("default") 

extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0
const MAX_JUMP = 2
const DASH_SPEED = 1000
const DASH_COOLDOWN = 2
const DASH_TIME = 0.25
const HEALTH = 3

var facingLeft = false
var jumpCount = 0

var dashCooldownTimer = 0.0
var isDashing = false
var dashTimer = 0.0
var dashDirection = 0

var cur_health = HEALTH

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var health_container: HBoxContainer = $"../../CanvasLayer/Hearts/HBoxContainer"

@export var particle : PackedScene
@export var slash : PackedScene

func jump():
	velocity.y = -700.0
	
func jump_side(x):
	velocity.y = JUMP_VELOCITY
	velocity.x = x

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			slash_effect(facingLeft)

func _physics_process(delta: float) -> void:
	
	if velocity.x != 0:
		if isDashing:
			sprite_2d.animation = "rolling"
		else:
			sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.animation = "jumping"
	
	if not is_on_floor() and velocity.y > 0:
		if isDashing:
			sprite_2d.animation = "rolling"
		else:
			sprite_2d.animation = "falling"
	
	
	if Input.is_action_just_pressed("ui_accept"):
		if jumpCount < MAX_JUMP:
			print(jumpCount)
			velocity.y = JUMP_VELOCITY
			if jumpCount >= 1:
				spawn_particle(position)
			jumpCount += 1
			
	
	# --- DASH LOGIC --- #
	if dashCooldownTimer > 0:
		dashCooldownTimer -= delta
		
	if isDashing:
		dashTimer -= delta
		if dashTimer<=0:
			isDashing = false
			dashCooldownTimer = DASH_COOLDOWN
			
	else:
		if Input.is_action_just_pressed("dash") and dashCooldownTimer <= 0:
			spawn_particle(position)
			if facingLeft:
				dashDirection = -1
			else:
				dashDirection = 1
			isDashing = true
			dashTimer = DASH_TIME
			
	#APPLY DASH VELOCITY
	if isDashing:
		velocity.x = dashDirection * DASH_SPEED
		velocity.y = 0
	else:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, 3000.0)
			

	if is_on_floor():
		jumpCount = 0
		
	
	if velocity.x < 0:
		facingLeft = true
	elif velocity.x > 0:
		facingLeft = false
		
	sprite_2d.flip_h = facingLeft
	
	move_and_slide()
	
func spawn_particle(pos:Vector2 ):
	var particle_node = particle.instantiate()
	particle_node.position = pos
	get_parent().add_child(particle_node)	
	
	await get_tree().create_timer(0.3).timeout
	particle_node.queue_free()
	
func slash_effect(left : bool):
	var slash_ef = slash.instantiate()
	slash_ef.position = position
	if facingLeft:
		slash_ef.position.x += -50
	else:
		slash_ef.position.x += 50
	get_parent().add_child(slash_ef)
	
	if left:
		slash_ef.flip_v = true
	
	await get_tree().create_timer(0.3).timeout
	slash_ef.queue_free()
	
	

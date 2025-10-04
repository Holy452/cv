extends CharacterBody2D

# Player movement constants
const GRAVITY = 1200.0
const FLY_FORCE = -600.0
const MAX_FALL_SPEED = 800.0
const MAX_RISE_SPEED = -500.0

# Visual effects
var trail_positions = []
var max_trail_length = 10

# Particle effects
@onready var thrust_particles = $ThrustParticles
@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D
@onready var animation_player = $AnimationPlayer

signal player_died

func _ready():
	add_to_group("player")

func _physics_process(delta):
	# Apply gravity
	velocity.y += GRAVITY * delta
	
	# Handle flying input
	if Input.is_action_pressed("fly"):
		velocity.y = FLY_FORCE
		if thrust_particles:
			thrust_particles.emitting = true
		# Tilt up when flying
		sprite.rotation = lerp(sprite.rotation, -0.2, 0.1)
	else:
		if thrust_particles:
			thrust_particles.emitting = false
		# Tilt down when falling
		sprite.rotation = lerp(sprite.rotation, clamp(velocity.y * 0.0005, -0.2, 0.4), 0.1)
	
	# Clamp velocity
	velocity.y = clamp(velocity.y, MAX_RISE_SPEED, MAX_FALL_SPEED)
	
	# Move the player
	move_and_slide()
	
	# Check if player hit the ground or ceiling
	if position.y > get_viewport_rect().size.y + 50 or position.y < -50:
		die()

func die():
	emit_signal("player_died")
	# Disable collision
	set_physics_process(false)
	# Play death animation
	if animation_player and animation_player.has_animation("die"):
		animation_player.play("die")

func reset():
	position = Vector2(200, 360)
	velocity = Vector2.ZERO
	sprite.rotation = 0
	set_physics_process(true)
	show()

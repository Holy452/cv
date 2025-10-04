extends CharacterBody2D

const GRAVITY: float = 1400.0
const FLAP_STRENGTH: float = 420.0
const FORWARD_SPEED: float = 200.0

var velocity_y: float = 0.0

func _physics_process(delta: float) -> void:
	# Gravity
	velocity_y += GRAVITY * delta
	
	# Flap input
	if Input.is_action_just_pressed("flap"):
		velocity_y = -FLAP_STRENGTH
	
	# Constant forward motion
	velocity.x = FORWARD_SPEED
	velocity.y = velocity_y
	
	move_and_slide()
	
	# Clamp to screen
    var viewport := get_viewport_rect()
    if position.y > viewport.size.y:
        if is_instance_valid(get_tree().current_scene) and get_tree().current_scene.has_method("game_over"):
            get_tree().current_scene.call_deferred("game_over")
        queue_free()

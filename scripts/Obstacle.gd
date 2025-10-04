extends Area2D

var speed = 300.0

func _ready():
	add_to_group("obstacles")
	body_entered.connect(_on_body_entered)

func _process(delta):
	position.x -= speed * delta
	
	# Remove if off screen
	if position.x < -200:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.die()

func set_speed(new_speed: float):
	speed = new_speed

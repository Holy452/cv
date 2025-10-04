extends Area2D

var speed = 300.0
var rotation_speed = 3.0

@onready var sprite = $Sprite
@onready var animation_player = $AnimationPlayer

signal coin_collected

func _ready():
	add_to_group("coins")
	body_entered.connect(_on_body_entered)
	if animation_player:
		animation_player.play("spin")

func _process(delta):
	position.x -= speed * delta
	sprite.rotation += rotation_speed * delta
	
	# Remove if off screen
	if position.x < -100:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("coin_collected")
		# Play collection effect
		if animation_player:
			animation_player.play("collect")
		else:
			queue_free()

func set_speed(new_speed: float):
	speed = new_speed

func _on_animation_finished(anim_name):
	if anim_name == "collect":
		queue_free()

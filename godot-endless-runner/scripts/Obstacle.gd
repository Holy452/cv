extends Node2D

@export var speed: float = 220.0
@onready var area: Area2D = $Area2D

func _ready() -> void:
    add_to_group("obstacle")
    area.body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
    position.x -= speed * delta
    if position.x < -100.0:
        queue_free()

func _on_body_entered(body: Node) -> void:
    if body is CharacterBody2D:
        if is_instance_valid(get_tree().current_scene) and get_tree().current_scene.has_method("game_over"):
            get_tree().current_scene.call_deferred("game_over")

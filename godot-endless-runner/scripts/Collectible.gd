extends Node2D

@export var speed: float = 220.0
@export var score_value: int = 1
@onready var area: Area2D = $Area2D

func _ready() -> void:
    add_to_group("collectible")
    area.body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
    position.x -= speed * delta
    if position.x < -100.0:
        queue_free()

func _on_body_entered(body: Node) -> void:
    if body is CharacterBody2D:
        var scene := get_tree().current_scene
        if is_instance_valid(scene) and scene.has_method("add_score"):
            scene.add_score(score_value)
        queue_free()

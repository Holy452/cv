extends Node2D

@onready var score_label: Label = $UI/Score
@onready var game_over_label: Label = $UI/GameOver
@onready var game: Node2D = $Game
@onready var obstacle_spawner: Node = $Game/ObstacleSpawner
@onready var collectible_spawner: Node = $Game/CollectibleSpawner

var player_scene: PackedScene = preload("res://scenes/Player.tscn")

var score: int = 0
var is_game_over: bool = false

func _ready() -> void:
	reset_game()

func reset_game() -> void:
	is_game_over = false
	score = 0
	score_label.text = "Score: %d" % score
	game_over_label.visible = false
    cleanup_world()
    ensure_player()
    # Start spawners
    if obstacle_spawner.has_method("start"):
        obstacle_spawner.start()
    if collectible_spawner.has_method("start"):
        collectible_spawner.start()

func add_score(amount: int) -> void:
	score += amount
	score_label.text = "Score: %d" % score

func game_over() -> void:
	is_game_over = true
	game_over_label.visible = true
    if obstacle_spawner.has_method("stop"):
        obstacle_spawner.stop()
    if collectible_spawner.has_method("stop"):
        collectible_spawner.stop()

func cleanup_world() -> void:
    for node in get_tree().get_nodes_in_group("obstacle"):
        if is_instance_valid(node):
            node.queue_free()
    for node in get_tree().get_nodes_in_group("collectible"):
        if is_instance_valid(node):
            node.queue_free()

func ensure_player() -> void:
    if not game.has_node("Player"):
        var p := player_scene.instantiate()
        if p is Node2D:
            p.position = Vector2(140, 640)
        game.add_child(p)

func _unhandled_input(event: InputEvent) -> void:
	if is_game_over and (event.is_action_pressed("ui_accept") or event.is_action_pressed("flap")):
		reset_game()

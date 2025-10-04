extends Node

@export var scene_to_spawn: PackedScene
@export var interval_seconds: float = 1.2
@export var start_x: float = 800.0
@export var min_y: float = 200.0
@export var max_y: float = 1000.0

var _timer: float = 0.0
var _running: bool = false

func start() -> void:
	_running = true
	_timer = interval_seconds

func stop() -> void:
	_running = false

func _process(delta: float) -> void:
	if not _running or scene_to_spawn == null:
		return
	_timer -= delta
	if _timer <= 0.0:
		_timer += interval_seconds
		var inst := scene_to_spawn.instantiate()
        if inst and inst is Node2D:
            inst.position = Vector2(start_x, randf_range(min_y, max_y))
            # Parent spawns under our parent (e.g., Game) for easier cleanup
            get_parent().add_child(inst)

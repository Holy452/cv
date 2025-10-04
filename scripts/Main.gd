extends Node2D

# Preload scenes
var laser_scene = preload("res://scenes/LaserObstacle.tscn")
var missile_scene = preload("res://scenes/MissileObstacle.tscn")
var zapper_scene = preload("res://scenes/ZapperObstacle.tscn")
var coin_scene = preload("res://scenes/Coin.tscn")

# Game variables
var score = 0
var distance = 0.0
var coins_collected = 0
var game_speed = 300.0
var is_game_over = false
var game_started = false

# Spawn timers
var obstacle_spawn_timer = 0.0
var coin_spawn_timer = 0.0
const OBSTACLE_SPAWN_INTERVAL = 2.0
const COIN_SPAWN_INTERVAL = 3.0

# Difficulty
var difficulty_timer = 0.0
const DIFFICULTY_INCREASE_INTERVAL = 10.0

# References
@onready var player = $Player
@onready var ui = $UI
@onready var game_over_ui = $GameOverUI
@onready var start_ui = $StartUI
@onready var parallax_bg = $ParallaxBackground

func _ready():
	# Connect player signal
	if player:
		player.player_died.connect(_on_player_died)
	
	# Hide game over UI
	if game_over_ui:
		game_over_ui.hide()
	
	# Show start UI
	if start_ui:
		start_ui.show()
	
	# Initialize parallax background speed
	if parallax_bg:
		parallax_bg.set_scroll_speed(game_speed)
	
	# Initialize UI
	update_ui()

func _process(delta):
	if not game_started:
		if Input.is_action_just_pressed("fly"):
			start_game()
		return
	
	if is_game_over:
		return
	
	# Update distance and score
	distance += game_speed * delta * 0.01
	score = int(distance) + coins_collected * 10
	update_ui()
	
	# Spawn obstacles
	obstacle_spawn_timer += delta
	if obstacle_spawn_timer >= OBSTACLE_SPAWN_INTERVAL:
		obstacle_spawn_timer = 0.0
		spawn_obstacle()
	
	# Spawn coins
	coin_spawn_timer += delta
	if coin_spawn_timer >= COIN_SPAWN_INTERVAL:
		coin_spawn_timer = 0.0
		spawn_coins()
	
	# Increase difficulty
	difficulty_timer += delta
	if difficulty_timer >= DIFFICULTY_INCREASE_INTERVAL:
		difficulty_timer = 0.0
		increase_difficulty()

func start_game():
	game_started = true
	if start_ui:
		start_ui.hide()

func spawn_obstacle():
	var obstacle_types = [laser_scene, missile_scene, zapper_scene]
	var obstacle_scene_to_spawn = obstacle_types[randi() % obstacle_types.size()]
	var obstacle = obstacle_scene_to_spawn.instantiate()
	
	# Set position based on type
	obstacle.position.x = get_viewport_rect().size.x + 100
	
	if obstacle_scene_to_spawn == laser_scene:
		# Laser from top or bottom
		if randf() > 0.5:
			obstacle.position.y = 150  # From top
		else:
			obstacle.position.y = get_viewport_rect().size.y - 150  # From bottom
	elif obstacle_scene_to_spawn == missile_scene:
		# Missile at random height
		obstacle.position.y = randf_range(100, get_viewport_rect().size.y - 100)
		obstacle.set_speed(game_speed + 100)
	else:  # Zapper
		obstacle.position.y = 200
	
	obstacle.set_speed(game_speed)
	add_child(obstacle)

func spawn_coins():
	var pattern = randi() % 3
	
	if pattern == 0:
		# Single coin
		spawn_single_coin()
	elif pattern == 1:
		# Horizontal line
		var y = randf_range(150, get_viewport_rect().size.y - 150)
		for i in range(5):
			var coin = coin_scene.instantiate()
			coin.position = Vector2(get_viewport_rect().size.x + 100 + i * 60, y)
			coin.set_speed(game_speed)
			coin.coin_collected.connect(_on_coin_collected)
			add_child(coin)
	else:
		# Wave pattern
		for i in range(7):
			var coin = coin_scene.instantiate()
			var x = get_viewport_rect().size.x + 100 + i * 50
			var y = 360 + sin(i * 0.8) * 150
			coin.position = Vector2(x, y)
			coin.set_speed(game_speed)
			coin.coin_collected.connect(_on_coin_collected)
			add_child(coin)

func spawn_single_coin():
	var coin = coin_scene.instantiate()
	coin.position = Vector2(
		get_viewport_rect().size.x + 100,
		randf_range(150, get_viewport_rect().size.y - 150)
	)
	coin.set_speed(game_speed)
	coin.coin_collected.connect(_on_coin_collected)
	add_child(coin)

func increase_difficulty():
	game_speed += 20.0
	if parallax_bg:
		parallax_bg.set_scroll_speed(game_speed)
	print("Difficulty increased! Speed: ", game_speed)

func _on_coin_collected():
	coins_collected += 1
	update_ui()

func _on_player_died():
	is_game_over = true
	show_game_over()

func show_game_over():
	if game_over_ui:
		game_over_ui.get_node("Panel/FinalScore").text = "Score: " + str(score)
		game_over_ui.get_node("Panel/FinalDistance").text = "Distance: " + str(int(distance)) + "m"
		game_over_ui.get_node("Panel/FinalCoins").text = "Coins: " + str(coins_collected)
		game_over_ui.show()

func update_ui():
	if ui:
		ui.get_node("ScoreLabel").text = "Score: " + str(score)
		ui.get_node("DistanceLabel").text = "Distance: " + str(int(distance)) + "m"
		ui.get_node("CoinsLabel").text = "Coins: " + str(coins_collected)

func restart_game():
	get_tree().reload_current_scene()

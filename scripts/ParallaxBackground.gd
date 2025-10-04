extends ParallaxBackground

var scroll_speed = 100.0

func _process(delta):
	scroll_offset.x -= scroll_speed * delta

func set_scroll_speed(speed: float):
	scroll_speed = speed * 0.3

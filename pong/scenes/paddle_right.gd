extends "res://base_paddle.gd"

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	set_boundaries()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	var input_direction = 0

	# Detect input for movement
	if Input.is_action_pressed("ui_up_right"):  # Move up (W key)
		input_direction -= 1
	if Input.is_action_pressed("ui_down_right"):  # Move down (S key)
		input_direction += 1

	# Move the paddle
	position.y += input_direction * paddle_speed * delta

	# Clamp paddle position within boundaries
	position.y = clamp(position.y, boundary_top, boundary_bottom)

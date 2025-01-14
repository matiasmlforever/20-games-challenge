extends "res://base_paddle.gd"

# Variables
@export var initial_speed: float = 6  # Ball speed in pixels per second
@export var speed_increase: float = 2.0  # Speed increase after each bounce
var direction: Vector2 = Vector2.ZERO  # Direction of the ball's movement

func _ready() -> void:
	set_boundaries() # límites
	set_starting_direction()
	
func set_starting_direction() -> void:
	# Loop until we find a valid direction
	while true:
		# Generate a random direction vector
		direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
		direction = direction.normalized()
		
		# Ensure the direction is not too vertical by checking the x component
		if abs(direction.x) > 0.3:  # Minimum horizontal component threshold
			break

	# Debug: Print the starting direction
	print("Starting direction: ", direction)

func _process(delta: float) -> void:
	# Move the ball
	position += direction * initial_speed * delta

	# Check for collisions
	check_boundaries()

# Function to handle collisions with walls or paddles
func check_boundaries() -> void:
	# Reset ball if it goes out of bounds (left or right)
	if position.x <= -30 or position.x >= 30:
		score(position.x)		
		reset_ball()

func score(x: float) -> void:
	var scorer = "left_player" if position.x > 0 else "right_player"
	emit_signal("mete_gol", scorer)

# Function to handle paddle collision response
func on_paddle_collision() -> void:
	direction.x *= -1  # Reverse horizontal direction
	direction = direction.normalized()
	initial_speed += speed_increase  # Speed up the ball

func on_wall_collision() -> void:
	direction.y *= -1
	direction = direction.normalized()

# Function to reset the ball after a score
func reset_ball() -> void:
	position = Vector2(0,0)
	initial_speed = 6  # Reset speed
	set_starting_direction()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("paddles"):
		on_paddle_collision()
	else:
		on_wall_collision()

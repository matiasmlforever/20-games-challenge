extends "res://base_paddle.gd"
# Variables
@export var initial_speed: float = 6  # Ball speed in pixels per second
@export var speed_increase: float = 2.0  # Speed increase after each bounce
var direction: Vector2 = Vector2.ZERO  # Direction of the ball's movement

func _ready() -> void:
	set_boundaries()
	set_starting_direction()
	
func set_starting_direction() -> void:
	# Set the initial direction of the ball (randomized)
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	# Ensure that the direction is normalized
	direction = direction.normalized()
	# If either direction is 0, we randomize it again
	if direction.x == 0:
		direction.x = 1.0 if randf() > 0.5 else -1.0
	if direction.y == 0:
		direction.y = 1.0 if randf() > 0.5 else -1.0

func _process(delta: float) -> void:
	# Move the ball
	position += direction * initial_speed * delta

	# Check for collisions
	check_boundaries()

# Function to handle collisions with walls or paddles
func check_boundaries() -> void:
	# Reset ball if it goes out of bounds (left or right)
	if position.x <= -30 or position.x >= 30:
		reset_ball()

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

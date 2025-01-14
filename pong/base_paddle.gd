extends Area2D

signal mete_gol(String)

# Variables
@export var paddle_speed: float = 50
@export var boundary_offset: float = 2.55
var boundary_top: float = 0.0  # Upper boundary
var boundary_bottom: float = 0.0  # Lower boundary

func set_boundaries() -> void:
	# Get sibling nodes by name
	var upper_wall = get_parent().get_node("MuroSuperiorCollisionArea")
	var lower_wall = get_parent().get_node("MuroInferiorCollisionArea")

	if upper_wall and lower_wall:
		# Set boundaries based on the global position of the walls
		boundary_top = upper_wall.global_position.y + boundary_offset
		boundary_bottom = lower_wall.global_position.y - boundary_offset
	else:
		print("Error: Could not find MuroSuperior or MuroInferior nodes.")

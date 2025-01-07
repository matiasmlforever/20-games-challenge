extends Container

# Declare a variable for the y-coordinate
var spacing: float = 2.0  # Spacing between duplicates


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	 # Assume there's a child sprite named "pixel" to set the starting position
	var anchor = $pixel
	if anchor:
		#y_start_coord = anchor.global_position.y
		draw_divider(anchor)
	else:
		print("Anchor node not found!")
	pass

# Function to create duplicates and arrange them vertically
func draw_divider(anchor) -> void:
	if not anchor:
		print("Anchor node not found, cannot create duplicates!")
		return

	for i in range(100):
		# Create a duplicate of the anchor
		var duplicado = anchor.duplicate() as Node2D
		duplicado.position = anchor.position + Vector2(0, i * spacing)  # Adjust position vertically
		add_child(duplicado)  # Add duplicate to the scene tree

	print("Created 100 duplicates of the anchor sprite.")

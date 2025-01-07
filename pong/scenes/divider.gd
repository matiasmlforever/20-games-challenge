extends Container

# Declare a variable for the y-coordinate
var y_start_coord: float = 0.0
var spacing: float = 2.0  # Spacing between duplicates


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	 # Assume there's a child sprite named "pixel" to set the starting position
	var anchor = $pixel
	if anchor:
		y_start_coord = anchor.global_position.y
		draw_divider(y_start_coord)
	else:
		print("Anchor node not found!")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to create duplicates and arrange them vertically
func draw_divider(start_position: float, direction: String = "south") -> void:
	var anchor = $pixel
	if not anchor:
		print("Anchor node not found, cannot create duplicates!")
		return

	for i in range(100):
		# Create a duplicate of the anchor
		var duplicate = anchor.duplicate() as Node2D
		duplicate.position = anchor.position + Vector2(0, i * spacing)  # Adjust position vertically
		add_child(duplicate)  # Add duplicate to the scene tree

	print("Created 100 duplicates of the anchor sprite.")

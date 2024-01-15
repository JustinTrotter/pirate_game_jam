extends Node2D

@onready var parent = self.get_parent()
@onready var direction = Vector2.ZERO

@export var magnitude: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#direction = Input.get_vector("left", "right", "up", "down")
	#if direction != Vector2.ZERO:
	#	position = parent.global_position + direction * magnitude
	position = Vector2(
		(Globals.current_screen.x * Globals.VIEWPORT_WIDTH + Globals.VIEWPORT_WIDTH / 2.0) - Globals.screen_offset_width,
		(Globals.current_screen.y * Globals.VIEWPORT_HEIGHT + Globals.VIEWPORT_HEIGHT / 2.0) - Globals.screen_offset_height
	)

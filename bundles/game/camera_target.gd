extends Node2D

@onready var parent = self.get_parent()
@onready var direction = Vector2.ZERO

@onready var prev_position = position

@export var magnitude: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector2(
		Globals.current_screen.x * Globals.VIEWPORT_WIDTH + Globals.VIEWPORT_WIDTH / 2.0,
		Globals.current_screen.y * Globals.VIEWPORT_HEIGHT + Globals.VIEWPORT_HEIGHT / 2.0
	)
	if prev_position != position:
		Globals.changed_level.emit()
		prev_position = position

extends Sprite2D

@export var graphic: Texture2D
@export var size: Vector2

@onready var mouse_in_chord = false

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = graphic


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_mouse_in_chord()
	
	if Input.is_action_just_released("Click"):
		if mouse_in_chord:
			texture = Globals.held_item

func check_mouse_in_chord():
	if not Rect2(-self.size, self.size * 2).has_point(self.get_local_mouse_position()):
		mouse_in_chord = false
	else:
		mouse_in_chord = true

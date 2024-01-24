extends TextureButton

@onready var item_held = false
@onready var default_cursor = load("res://assets/resources/cursor_arrow.png")
@onready var image
@onready var item_index

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("Click"):
		if item_held == true:
			Input.set_custom_mouse_cursor(default_cursor, 0, Vector2(0, 0))
			item_held = false
			
			

func _on_button_down():
	Input.set_custom_mouse_cursor(image, 0, Vector2(12, 14))
	item_held = true;
	Globals.held_item = image
	Globals.held_index = item_index

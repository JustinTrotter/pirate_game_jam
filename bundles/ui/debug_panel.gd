extends Panel

@onready var camera = get_tree().get_nodes_in_group("Camera")[0]  

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.game_paused:
		self.visible = true
	else:
		self.visible = false


func _on_camera_smooth_move_checkbox_toggled(toggled_on):
	camera.position_smoothing_enabled = toggled_on


func _on_camera_move_speed_ui_line_edit_text_changed(new_text):
	camera.position_smoothing_speed = float(new_text)

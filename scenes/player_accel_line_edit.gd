extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = str(Globals.player_accel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_text_changed(new_text):
	Globals.player_accel = float(new_text)

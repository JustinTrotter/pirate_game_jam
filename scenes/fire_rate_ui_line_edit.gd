extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = str(Globals.fire_rate)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_text_changed(new_text):
	Globals.fire_rate = float(new_text)

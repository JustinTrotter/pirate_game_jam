extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.game_paused:
		self.visible = true
	else:
		self.visible = false

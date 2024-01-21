extends Camera2D

@onready var camera_target = get_tree().get_nodes_in_group("CameraTarget")[0]  

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_tree().get_nodes_in_group("CameraTarget"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = camera_target.position

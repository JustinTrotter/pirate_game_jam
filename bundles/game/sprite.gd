extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = get_parent().velocity
	if velocity && velocity.x > 0:
		scale.x = 1
	else:
		scale.x = -1
		

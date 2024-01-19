extends Node2D

func _physics_process(delta):
	get_parent().direction = Input.get_vector("left", "right", "up", "down")

extends Node2D

@export var retain_last_direction: bool
@onready var previous_direction = Vector2.UP

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction == Vector2.ZERO && retain_last_direction:
		direction = previous_direction
	else:
		previous_direction = direction
	get_parent().direction = direction

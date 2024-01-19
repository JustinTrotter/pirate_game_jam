extends Node2D

@onready var parent = self.get_parent()
@onready var direction = Vector2.ZERO

@export var speed: float
@export var accel: float

func _physics_process(delta):
	if !Globals.game_paused:
		if get_children().size() == 0:
			default_behavior()
		parent.velocity.x = move_toward(parent.velocity.x, speed * direction.x, accel)
		parent.velocity.y = move_toward(parent.velocity.y, speed * direction.y, accel)
		parent.move_and_slide()

func default_behavior():
	direction = Input.get_vector("left", "right", "up", "down")

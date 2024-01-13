extends CharacterBody2D

var speed: float = 200  # speed in pixels/sec
var accel: float = 50

func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)

	move_and_slide()

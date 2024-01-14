extends CharacterBody2D

var accel: float = 50

func _physics_process(delta):
	if !Globals.game_paused:
		var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
		velocity.x = move_toward(velocity.x, Globals.player_speed * direction.x, accel)
		velocity.y = move_toward(velocity.y, Globals.player_speed * direction.y, accel)
		move_and_slide()

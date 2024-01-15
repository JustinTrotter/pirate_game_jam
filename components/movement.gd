extends Node2D

@onready var parent = self.get_parent()

func _physics_process(delta):
	if !Globals.game_paused:
		var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
		parent.velocity.x = move_toward(parent.velocity.x, Globals.player_speed * direction.x, Globals.player_accel)
		parent.velocity.y = move_toward(parent.velocity.y, Globals.player_speed * direction.y, Globals.player_accel)
		parent.move_and_slide()

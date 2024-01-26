extends Area2D

@export var speed = -250
@onready var scaling = false
@onready var shoot_direction


func start(pos):
	shoot_direction = Vector2.UP

	position = pos
	

func _process(delta):
	if !Globals.game_paused:
		face_towards_direction()
		position.x += speed * delta * -shoot_direction.x
		position.y += speed * delta * -shoot_direction.y
		#tween_scale()
		
func tween_scale():
	if !scaling:
		scaling = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(2.0, 10.0), 1.0)
		tween.tween_callback(_on_scale_complete)

func _on_scale_complete():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 1.0)
	tween.tween_callback(_on_fade_complete)
	
func _on_fade_complete():
	queue_free()

func face_towards_direction():
	rotation = shoot_direction.angle()

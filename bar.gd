extends Node2D

@onready var start_position = %"Start Position"
@onready var target_position = %"Target Position"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		_move_bar()

func _move_bar():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_position.global_position, 1.0)
	tween.tween_callback(_on_tween_complete)

func _on_tween_complete():
	self.global_position = start_position.global_position
	Globals.tempo_tick.emit()
	_move_bar()

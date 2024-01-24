extends Node2D

@onready var start_position = %"Start Position"
@onready var chord_1 = %chord_1
@onready var chord_2 = %chord_2
@onready var chord_3 = %chord_3
@onready var chord_4 = %chord_4
@onready var chord_5 = %"Target Position"

@onready var note_number = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	_move_bar(chord_2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _move_bar(target):
	if !Globals.game_paused:
		Globals.tempo_tick.emit(get("chord_" + str(note_number - 1)).bullet_scene)
	note_number += 1
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target.global_position, Globals.fire_rate)
	tween.tween_callback(_on_tween_complete)
	
func _on_tween_complete():
	if note_number == 6:
		self.global_position = start_position.global_position
		note_number = 2
	_move_bar(get("chord_" + str(note_number)))

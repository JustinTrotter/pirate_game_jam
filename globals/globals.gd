extends Node

signal tempo_tick

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause_game"):
		Globals.game_paused = !Globals.game_paused

@export var player_speed: float = 200.0
@export var player_accel: float = 50.0
@export var fire_rate: float = 1.0

var game_paused: bool = false

extends Node

signal tempo_tick

@onready var player = get_tree().get_nodes_in_group("Player")[0]  

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause_game"):
		Globals.game_paused = !Globals.game_pausedd
	if player:
		_update_current_screen()

@export var player_speed: float = 200.0
@export var player_accel: float = 50.0
@export var fire_rate: float = 1.0

var game_paused: bool = false

var VIEWPORT_WIDTH = 480.0
var VIEWPORT_HEIGHT = 304.0
var current_screen = Vector2.ZERO
var screen_offset_width = 55.0;
var screen_offset_height = 90.0;

func _update_current_screen():
	current_screen.x =  floor((player.global_position.x + screen_offset_width) / VIEWPORT_WIDTH)
	current_screen.y = floor((player.global_position.y + screen_offset_height) / VIEWPORT_HEIGHT)
	print(current_screen)

extends Node

signal tempo_tick
signal changed_level

@onready var map_grid_width = 9
@onready var map_grid_height = 7

@onready var level_screen_tile_width = 30
@onready var level_screen_tile_height = 16

@onready var player = get_tree().get_nodes_in_group("Player")[0]  
@onready var rng = RandomNumberGenerator.new()

@onready var held_item
@onready var held_index = -1

@onready var total_spawned_enemies = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#rng.seed = hash("Pirate_Game_Jam_Seed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause_game"):
		Globals.game_paused = !Globals.game_paused
	if player:
		_update_current_screen()

@export var player_speed: float = 200.0
@export var player_accel: float = 50.0
@export var fire_rate: float = 1.0

var game_paused: bool = false

var VIEWPORT_WIDTH = 480.0
var VIEWPORT_HEIGHT = 256.0
var current_screen = Vector2.ZERO

var map_grid_positions: PackedVector2Array
var map_grid_levels: Array

func _update_current_screen():
	current_screen.x =  floor(player.global_position.x / VIEWPORT_WIDTH)
	current_screen.y = floor(player.global_position.y / VIEWPORT_HEIGHT)

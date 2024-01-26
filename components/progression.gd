extends Node2D

@onready var prev_level = 1
@onready var level = 1
@onready var exp = 0
@onready var constA = 8.7
@onready var constB = -40
@onready var constC = 111

# Called when the node enters the scene tree for the first time.
func _ready():
	print("LEVEL UP! Next level is in: ", calculate_xp_for_level(level + 1))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func increase_exp(value: float):
	exp += value
	print("exp: ", exp)
	handle_level_up()

func handle_level_up():
	level = max(floor( constA * log( exp + constC ) + constB ), 1 )
	if prev_level != level:
		print("LEVEL UP! Next level is in: ", calculate_xp_for_level(level + 1))
		prev_level = level
		
func calculate_xp_for_level(level: int) -> float:
	var xp = exp((level - constB) / constA) - constC
	return max(floor(xp), 0)

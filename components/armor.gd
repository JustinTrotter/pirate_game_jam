extends Node2D

# armor is a float value between 0 and 1
@export var armor: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reduce_damage(value: float) -> float:
	return value - (value * armor)

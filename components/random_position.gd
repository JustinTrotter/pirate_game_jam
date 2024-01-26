extends Node2D

@export var min_distance: int
@export var max_distance: int
@export var wait_time: float
@onready var timer = find_child("Timer")

@onready var target_position: Vector2
@onready var rng = Globals.rng

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = wait_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	generate_random_position()

func generate_random_position():
	target_position = Vector2(rng.randi_range(min_distance, max_distance), rng.randi_range(min_distance, max_distance))
	get_parent().on_changed_level()

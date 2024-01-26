extends Node2D

@onready var player_progression = get_tree().get_nodes_in_group("Player")[0].find_child("Progression")

@onready var parent = get_parent();
@onready var health_component;

@export var exp_on_death: int

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component = parent.find_child("Health")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dead():
		Globals.total_spawned_enemies -= 1
		player_progression.increase_exp(exp_on_death)
		parent.queue_free()

func is_dead() -> bool:
	if health_component:
		return health_component.health <= 0
	return false

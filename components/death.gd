extends Node2D

@onready var parent = get_parent();
@onready var health_component;

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component = parent.find_child("Health")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dead():
		parent.queue_free()

func is_dead() -> bool:
	if health_component:
		return health_component.health <= 0
	return false

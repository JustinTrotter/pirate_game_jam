extends Node

@export var local_bullet: PackedScene

@onready var map = get_tree().get_nodes_in_group("Map")[0] 

@onready var parent = self.get_parent()

@onready var direction = Vector2.UP

var toggle = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("tempo_tick", shoot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_children().size() == 0:
		default_behavior()

func shoot(bullet: PackedScene) -> void:
	var shooty_bullet = bullet
	if local_bullet:
		shooty_bullet = local_bullet
	#if Input.is_action_just_pressed("shoot"):\
	var bullet_instance = shooty_bullet.instantiate()
	bullet_instance.global_position = parent.global_position

	bullet_instance.shoot_direction = direction
	map.add_child(bullet_instance)
#
	#toggle = !toggle
	pass

func default_behavior():
	direction = Vector2.UP
	

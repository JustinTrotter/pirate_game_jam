extends Node

var bullet_a: PackedScene = preload("res://bundles/game/bullet_A.tscn")
var bullet_b: PackedScene = preload("res://bundles/game/bullet_B.tscn")

@onready var map = get_tree().get_nodes_in_group("Map")[0] 

@onready var parent = self.get_parent()


var toggle = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("tempo_tick", shoot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot() -> void:
	print("SHOOT")

	#if Input.is_action_just_pressed("shoot"):\
	var bullet_instance
	if (toggle):
		bullet_instance = bullet_a.instantiate()
	else:
		bullet_instance = bullet_b.instantiate()
	bullet_instance.global_position = parent.global_position

	map.add_child.call_deferred(bullet_instance)

	toggle = !toggle

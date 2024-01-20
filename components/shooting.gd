extends Node

var bullet_a: PackedScene = preload("res://bundles/game/bullet_A.tscn")
var bullet_b: PackedScene = preload("res://bundles/game/bullet_B.tscn")

@onready var parent = self.get_parent()

var toggle = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("tempo_tick", shoot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot() -> void:
	#if Input.is_action_just_pressed("shoot"):\
	var bullet_instance
	if (toggle):
		bullet_instance = bullet_a.instantiate()
	else:
		bullet_instance = bullet_b.instantiate()
	get_tree().root.add_child.call_deferred(bullet_instance)
	bullet_instance.global_transform = parent.global_transform
	toggle = !toggle

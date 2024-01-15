extends Node

var bullet_a: PackedScene = preload("res://bundles/game/bullet_A.tscn")
var bullet_b: PackedScene = preload("res://bundles/game/bullet_B.tscn")

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
	self.add_child(bullet_instance)
	bullet_instance.transform = owner.get_child(0).transform
	toggle = !toggle

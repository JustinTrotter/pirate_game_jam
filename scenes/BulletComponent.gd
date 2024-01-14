extends Node

@export var bullet: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("tempo_tick", shoot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot() -> void:
	#if Input.is_action_just_pressed("shoot"):
	var bullet_instance = bullet.instantiate()
	self.add_child(bullet_instance)
	bullet_instance.transform = owner.get_child(0).transform

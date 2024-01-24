extends Node2D

@onready var spawn: PackedScene = preload("res://bundles/game/enemy.tscn")
@onready var spawn_rate: float = 1.0

@onready var grand_parent = get_parent().get_parent()
@onready var paused: bool = false

@onready var spawn_quantity = 0

func _ready():
	pass 

func _process(delta):
	spawn_quantity += delta * spawn_rate
	if spawn_quantity >= 1:
		var spawn_count: float = floor(spawn_quantity)
		spawn_quantity -= spawn_count

		for index in int(spawn_count):
			do_spawn()

func do_spawn():
	var new_spawn = spawn.instantiate()
	add_child(new_spawn)
	new_spawn.reparent(grand_parent)
	var path = new_spawn.find_child("Movement").find_child("PathToPlayer")
	if path:
		path.on_changed_level()

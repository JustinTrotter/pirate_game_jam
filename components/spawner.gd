extends Node2D

@onready var game_screen = get_tree().get_nodes_in_group("GameScreen")[0]

@export var spawn_rate: float
@export var spawn_quantity: int

@onready var grand_parent = get_parent().get_parent()
@onready var paused: bool = false


func _ready():
	pass

func _process(delta):
	pass

func do_spawn():
	var new_spawn = AssetCache.enemy.instantiate()
	new_spawn.position = Vector2(new_spawn.position.x + 5, new_spawn.position.y + 5)
	add_child(new_spawn)
	new_spawn.reparent(game_screen)
	remove_child(new_spawn)
	#print("spawn_spawner: ", spawn_spawner)
	var path = new_spawn.find_child("Movement").find_child("PathToPlayer")


	if path:
		path.on_changed_level()


func _on_timer_timeout():
	if Globals.total_spawned_enemies < 25:
		do_spawn()
		Globals.total_spawned_enemies += 1

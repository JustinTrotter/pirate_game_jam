extends Node2D

@onready var enemies = get_tree().get_nodes_in_group("Enemy")

@onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var closest_enemy = get_closest_enemy()
	if closest_enemy:
		parent.direction = (closest_enemy.global_position - parent.global_position).normalized()

func get_closest_enemy() -> Node2D:
	enemies = get_tree().get_nodes_in_group("Enemy")
	if enemies.size() == 0: return
	var closest_enemy = enemies[0]
	var closest_distance = parent.global_position.distance_to(enemies[0].global_position)
	for enemy in enemies:
		var distance = parent.global_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	return closest_enemy

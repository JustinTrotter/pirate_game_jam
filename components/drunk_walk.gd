extends Node2D
  
@onready var a_star = get_tree().get_nodes_in_group("A_Star")[0]

@export var target: PackedScene
@onready var target_position

@onready var a_star_wall_grid = a_star.astar_grid
@onready var a_star_fly_grid = a_star.astar_fly_grid

@onready var a_star_current_grid = a_star_wall_grid

@onready var grand_parent = get_parent().get_parent()

func _ready():
	Globals.connect("changed_level", on_changed_level)
		
func on_changed_level():
	if target:
		target_position = grand_parent.position + target_position
	elif get_children().size() > 0 && get_children()[0].target_position != Vector2.ZERO:
		target_position = get_children()[0].target_position
	else:
		target_position = self.position
		
	if get_parent().get_parent().has_node("Flying"):
		a_star_current_grid = a_star.astar_fly_grid
	else:
		a_star_current_grid = a_star.astar_grid
	

func get_relative_tile_position(tile_position: Vector2, level_position: Vector2) -> Vector2:
	var result = Vector2(
		tile_position.x - (Globals.level_screen_tile_width * level_position.x), 
		tile_position.y - (Globals.level_screen_tile_height * level_position.y))
	return result
	
func undo_relative_tile_position(relative_tile_position: Vector2, level_position: Vector2) -> Vector2:
	var result = Vector2(
		relative_tile_position.x + (Globals.level_screen_tile_width * level_position.x),
		relative_tile_position.y + (Globals.level_screen_tile_height * level_position.y))
	return result


func _physics_process(delta):
	if target_position && a_star_current_grid != null:
		var level_position = a_star.get_grid_coords_from_position(get_parent().get_parent().position)
		var tile_position = a_star.get_tile_coords_from_position(get_parent().get_parent().position)
		var relative_tile_position = get_relative_tile_position(tile_position, level_position)
		var target_level_position = a_star.get_grid_coords_from_position(target_position)
		var target_tile_position = a_star.get_tile_coords_from_position(target_position)
		var target_relative_tile_position = get_relative_tile_position(target_tile_position, target_level_position)
		var path = a_star_current_grid.get_id_path(relative_tile_position, target_relative_tile_position)
		if path.size() <= 1: return
		var undo_relative_target_position = undo_relative_tile_position(path[1], level_position)
		var undo_target_tile_coords_from_position = a_star.get_position_from_tile_coords(undo_relative_target_position)
		get_parent().direction = ((undo_target_tile_coords_from_position + Vector2(8, 8)) - get_parent().get_parent().position).normalized()


extends Node2D

@onready var player = get_tree().get_nodes_in_group("Player")[0]  
@onready var a_star = get_tree().get_nodes_in_group("A_Star")[0]

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
	var level_position = a_star.get_grid_coords_from_position(get_parent().get_parent().position)
	var tile_position = a_star.get_tile_coords_from_position(get_parent().get_parent().position)
	var relative_tile_position = get_relative_tile_position(tile_position, level_position)
	var player_level_position = a_star.get_grid_coords_from_position(player.position)
	var player_tile_position = a_star.get_tile_coords_from_position(player.position)
	var player_relative_tile_position = get_relative_tile_position(player_tile_position, player_level_position)
	var path = a_star.astar_grid.get_id_path(relative_tile_position, player_relative_tile_position)
	if path.size() == 1: return
	var undo_relative_target_position = undo_relative_tile_position(path[1], level_position)
	var undo_target_tile_coords_from_position = a_star.get_position_from_tile_coords(undo_relative_target_position)
	get_parent().direction = ((undo_target_tile_coords_from_position + Vector2(8, 8)) - get_parent().get_parent().position).normalized()


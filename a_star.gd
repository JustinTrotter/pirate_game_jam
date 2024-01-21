extends Node2D

@onready var map = get_parent()
@onready var camera_target = get_tree().get_nodes_in_group("CameraTarget")[0]  
@onready var astar_grid = AStarGrid2D.new()
@onready var astar_fly_grid = AStarGrid2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("changed_level", on_changed_level)
	setup_grid(astar_grid)
	setup_grid(astar_fly_grid)
	
func setup_grid(grid: AStarGrid2D):
	grid.region = Rect2i(0, 0, Globals.level_screen_tile_width, Globals.level_screen_tile_height)
	grid.cell_size = Vector2(1, 1)
	grid.update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_grid_coords_from_position(position: Vector2) -> Vector2:
	var result = Vector2(
		floor(position.x / Globals.VIEWPORT_WIDTH), 
		floor(position.y / Globals.VIEWPORT_HEIGHT))
	return result

func get_position_from_grid_coords(grid_coords: Vector2) -> Vector2:
	var result = Vector2(
		floor(grid_coords.x * Globals.VIEWPORT_WIDTH), 
		floor(grid_coords.y * Globals.VIEWPORT_HEIGHT))
	return result
	
func get_tile_coords_from_position(position: Vector2) -> Vector2:
	var result = Vector2(
		floor(position.x / 16), 
		floor(position.y / 16))
	return result
	
func get_position_from_tile_coords(tile_coords: Vector2) -> Vector2:
	var result = Vector2(
		floor(tile_coords.x * 16), 
		floor(tile_coords.y * 16))
	return result
	
func level_position_from_tile_position(tile_position: Vector2) -> Vector2:
	var result = Vector2(
		floor(tile_position.x * Globals.level_screen_tile_width), 
		floor(tile_position.y * Globals.level_screen_tile_height))
	return result

func on_changed_level():
	update_astar_grid_with_wall_data(astar_grid, ["Walls", "Water"])
	update_astar_grid_with_wall_data(astar_fly_grid, ["Walls"])
	
func update_astar_grid_with_wall_data(grid: AStarGrid2D, collision_names):
	var non_null_levels = map.level_lookup_map.filter(func (level): 
		return level != null)
	var target_level_node = non_null_levels.filter(func (level): 
		return get_grid_coords_from_position(level.position) == get_grid_coords_from_position(camera_target.position))[0]
	var target_level_map = target_level_node.get_children()[0]
	for i in range(0, Globals.level_screen_tile_width):
		for j in range(0, Globals.level_screen_tile_height):
			grid.set_point_solid(Vector2i(i, j), false)
			var target_tile_data = target_level_map.get_cell_tile_data(0, Vector2(i,j)).get_custom_data_by_layer_id(0)
			for name in collision_names:
				if target_tile_data != {}:
					if target_tile_data["enums"][0] == name:
						grid.set_point_solid(Vector2i(i, j), true)

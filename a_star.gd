extends Node2D

@onready var map = get_parent()
@onready var camera_target = get_tree().get_nodes_in_group("CameraTarget")[0]  
@onready var astar_grid = AStarGrid2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("changed_level", on_changed_level)
	
	astar_grid.region = Rect2i(0, 0, 5, 5)
	astar_grid.cell_size = Vector2(16, 16)
	astar_grid.update()
	#print(astar_grid.get_id_path(Vector2i(0, 0), Vector2i(3, 4))) # prints (0, 0), (1, 1), (2, 2), (3, 3), (3, 4)
	#print(astar_grid.get_point_path(Vector2i(0, 0), Vector2i(3, 4))) # prints (0, 0), (16, 16), (32, 32), (48, 48), (48, 64)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_grid_coords_from_position(position: Vector2) -> Vector2:
	var result = Vector2(
		floor(position.x / Globals.VIEWPORT_WIDTH), 
		floor(position.y / Globals.VIEWPORT_HEIGHT))
	return result

func on_changed_level():
	var non_null_levels = map.level_lookup_map.filter(func (level): 
		return level != null)
	var target_level_node = non_null_levels.filter(func (level): 
		return get_grid_coords_from_position(level.position) == get_grid_coords_from_position(camera_target.position))[0]
	var target_level_map = target_level_node.get_children()[0]
	# TODO: OKAY I FINALLY FOUND THE WALL! iterate through each tile and set the astar grid to a wall if its all wall here
	var target_tile_data = target_level_map.get_cell_tile_data(0, Vector2(8,3)).get_custom_data_by_layer_id(0)
	print("target_tile_data: ", target_tile_data)

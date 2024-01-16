extends Node2D

@onready var level_nodes = get_children()
@onready var grid_width = 9
@onready var grid_height = 8
@onready var current_level_number = 1
@onready var max_number_of_levels = Globals.rng.randi_range(1, 2) + 5 + current_level_number * 2.6
@onready var levels_added = 0
@onready var level_cells = []
@onready var level_queue = []
@onready var num_level_nodes = 0

func _ready():
	initialize_level_nodes()
	initialize_level_cells()
	create_map_grid_positions(9, 8)
	place_starting_level_into_queue(35)
	loop_over_level_queue()
	
func initialize_level_cells():
	level_cells = []
	level_cells.resize(grid_width * grid_height)
	level_cells.fill(false)
	
func increase_level_number():
	current_level_number += 1
	max_number_of_levels = Globals.rng.randi_range(1, 2) + 5 + current_level_number * 2.6
	
func initialize_level_nodes():
	num_level_nodes = level_nodes.size()
	for level in level_nodes:
		level.visible = false
	#always initialize level zero
	level_nodes[0].visible = true
	
func create_map_grid_positions(grid_width: int, grid_height: int):
	for i in range(grid_width):
		for j in range(grid_height):
			Globals.map_grid_positions.append(Vector2(i * Globals.VIEWPORT_WIDTH, j * Globals.VIEWPORT_HEIGHT))
	
func get_bottom_of_map_grid() -> PackedVector2Array:
	return Globals.map_grid_positions.slice(grid_width * grid_height - grid_width)
	
func place_starting_level_into_queue(cell: int):
	level_cells[cell] = false
	Utils.add_to_queue(level_queue, cell)
	var level_coords = get_level_coords_from_cell(35)
	level_nodes[0].position = Vector2(level_coords.x * Globals.VIEWPORT_WIDTH, level_coords.y * Globals.VIEWPORT_HEIGHT)
	
func loop_over_level_queue():
	while !level_queue.is_empty():
		var level = level_queue[0]
	#for level in level_queue:
		if neighbor_is_good(level + 10, levels_added): levels_added += 1 #north
		if neighbor_is_good(level + 1, levels_added): levels_added += 1 #east
		if neighbor_is_good(level - 10, levels_added): levels_added += 1 #south
		if neighbor_is_good(level - 1, levels_added): levels_added += 1 #west
		Utils.finish_queue_front(level_queue)
			
func neighbor_is_good(neighbor: int, levels_added: int) -> bool:
	# if neighbor is out of bounds of map
	if neighbor < 0: return false
	if neighbor >= grid_width * grid_height : return false
	# if we already have enough rooms
	if levels_added >= floor(max_number_of_levels): return false
	# if neighbor is already occupied
	if level_cells[neighbor] != false: return false
	# if neighbor has more than one filled neighbor
	var number_of_filled_neighbors = 0
	if neighbor + 10 < grid_width * grid_height && level_cells[neighbor + 10] != false: 
			number_of_filled_neighbors += 1
	if neighbor + 1 < grid_width * grid_height && level_cells[neighbor + 1] != false:
			number_of_filled_neighbors += 1
	if neighbor - 10 >= 0 && level_cells[neighbor - 10] != false: 
		number_of_filled_neighbors += 1
	if neighbor - 1 >= 0 && level_cells[neighbor - 1] != false:
		number_of_filled_neighbors += 1
	if number_of_filled_neighbors > 1: return false
	# random 50% chance
	if Globals.rng.randi_range(1, 2) == 1: 
		return false
	level_cells[neighbor] = true
	Utils.add_to_queue(level_queue, neighbor)
	var level_coords = get_level_coords_from_cell(neighbor)
	create_level_at_location(level_coords.x, level_coords.y)
	return true
	
func create_level_at_location(x: int, y: int):
	var new_level = level_nodes[Globals.rng.randi_range(1, num_level_nodes - 1)].duplicate()
	new_level.position = Vector2(x * Globals.VIEWPORT_WIDTH, y * Globals.VIEWPORT_HEIGHT)
	new_level.visible = true
	add_child(new_level)

func get_level_coords_from_cell(cell: int) -> Vector2:
	if str(cell).length() == 2:
		return Vector2(int(str(cell)[1]), int(str(cell)[0]))
	return Vector2(int(str(cell)[0]), 0)
	

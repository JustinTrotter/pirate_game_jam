extends Panel

@onready var map = get_tree().get_nodes_in_group("Map")[0]  
@onready var room = preload("res://bundles/ui/mini_map_room.tscn")
@onready var room_hash_map = {}

@onready var previous_screen_coords = Vector2(5, 3)

@onready var visited_color = Color(Color.DIM_GRAY, 1.0)
@onready var current_color = Color.WEB_GREEN
@onready var seen_color = Color(Color.DIM_GRAY, 0.1)

func _ready():
	Globals.connect("changed_level", on_changed_level)
	generate_rooms()
	clear_rooms()

func generate_rooms():
	for i in range(0, Globals.map_grid_height):
		for j in range(0, Globals.map_grid_width):
			var new_room = room.instantiate()
			%GridContainer.add_child(new_room)
			room_hash_map[str(j) + "," + str(i)] = new_room 

func clear_rooms():
	for room in %GridContainer.get_children():
		room.color = Color(Color.DIM_GRAY, 0.0)
	#room_hash_map["4,3"].color = Color(current_color, 1.0)
	
func check_unvisted_neighbor_rooms():
	var current_map_cell = int(str(Globals.current_screen.y) + str(Globals.current_screen.x))
	# north
	if Globals.current_screen.y > 0:
		var north_room = room_hash_map[screen_coords_to_room_hash(Vector2(Globals.current_screen.x, Globals.current_screen.y - 1))]
		if map.level_cells[current_map_cell - 10] && north_room.color != visited_color:
			north_room.color = seen_color
	# east
	if Globals.current_screen.x < Globals.map_grid_width:
		var east_room = room_hash_map[screen_coords_to_room_hash(Vector2(Globals.current_screen.x + 1, Globals.current_screen.y))]
		if map.level_cells[current_map_cell + 1] && east_room.color != visited_color:
			east_room.color = seen_color
	# south
	if Globals.current_screen.y < Globals.map_grid_height - 2:
		var south_room = room_hash_map[screen_coords_to_room_hash(Vector2(Globals.current_screen.x, Globals.current_screen.y + 1))]
		if map.level_cells[current_map_cell + 10] && south_room.color != visited_color:
			south_room.color = seen_color
	# west
	if Globals.current_screen.x > 1:
		var west_room = room_hash_map[screen_coords_to_room_hash(Vector2(Globals.current_screen.x - 1, Globals.current_screen.y))]
		if map.level_cells[current_map_cell - 1] && west_room.color != visited_color:
			west_room.color = seen_color

func screen_coords_to_room_hash(coords: Vector2) -> String:
	return str(coords.x - 1) + "," + str(coords.y)

func on_changed_level():
	check_unvisted_neighbor_rooms()
	room_hash_map[screen_coords_to_room_hash(previous_screen_coords)].color = Color(visited_color, 1.0)
	room_hash_map[screen_coords_to_room_hash(Globals.current_screen)].color = Color(current_color, 1.0)
	previous_screen_coords = Globals.current_screen

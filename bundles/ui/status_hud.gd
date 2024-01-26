extends CanvasLayer

@export var is_top: bool

@onready var show_top: bool

@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var player_progression = player.find_child("Progression")
@onready var camera = get_tree().get_nodes_in_group("Camera")[0]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if should_reposition_bar(): 
		reposition_bar()
	var percentage = ((player_progression.exp - player_progression.calculate_xp_for_level(player_progression.level)) / (player_progression.calculate_xp_for_level(player_progression.level + 1) - player_progression.calculate_xp_for_level(player_progression.level))) * 100
	%ProgressBar.value = percentage

func should_reposition_bar() -> bool:
	return abs(abs(player.global_position.y) - abs(camera.global_position.y)) > 40

func reposition_bar():
	if player.global_position.y < camera.global_position.y:
		visible = !is_top
		show_top = false
	else:
		visible = is_top
		show_top = true

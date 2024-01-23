extends CanvasLayer
@onready var hud_panel = $HBoxContainer

@onready var inventory_panel = %InventoryPanel
@onready var inventory_open_position = %InventoryOpenPosition
@onready var inventory_close_position = %InventoryClosePosition
@onready var is_tweening = false
@onready var is_open = false

@onready var inventory_grid = %InventoryGrid

@onready var weapon_tileset = "res://icon.svg"
@onready var weapon_graphic_frame = 0

@onready var mouse_in_inventory = false
@onready var mouse_in_hud = false

@onready var item_scene: PackedScene = preload("res://bundles/ui/item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	load_inventory_items()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_mouse_in_hud()
	check_mouse_in_inventory()
	
	if Input.is_action_just_pressed("Click"):
		if !mouse_in_inventory && !mouse_in_hud && is_open:
			_on_weapon_button_pressed()
			
func check_mouse_in_hud():
	if not Rect2(Vector2.ZERO, hud_panel.size).has_point(hud_panel.get_local_mouse_position()):
		mouse_in_hud = false
	else:
		mouse_in_hud = true
	
func check_mouse_in_inventory():
	if not Rect2(Vector2.ZERO, inventory_panel.size).has_point(inventory_panel.get_local_mouse_position()):
		mouse_in_inventory = false
	else:
		mouse_in_inventory = true
	
func load_inventory_items():
	for i in range(0, 15):
		var item = item_scene.instantiate()
		var image = AssetCache.bullets[i % AssetCache.bullets.size()]
		item.image = image
		item.texture_normal = image
		inventory_grid.add_child(item)

func _on_weapon_button_pressed():
	if is_tweening: return
	
	is_tweening = true
	var tween = get_tree().create_tween()
	tween.set_parallel(false)
	if !is_open:
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(inventory_panel, "position", inventory_open_position.position, 0.50)
	else: 
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property(inventory_panel, "position", inventory_close_position.position, 0.125)
	is_open = !is_open
	
	tween.tween_callback(_on_tween_complete)

func _on_tween_complete():
	is_tweening = false


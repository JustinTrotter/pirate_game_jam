extends Node2D

@onready var parent = get_parent()
@onready var damage_component = parent.find_child("Damage")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bullet_base_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if !damage_component:
		return
	damage_component.damage(1.0)

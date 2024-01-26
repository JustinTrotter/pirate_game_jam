extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bullet_base_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	var damage_component = body.find_child("Damage")
	if damage_component:
		damage_component.damage(100)


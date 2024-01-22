extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().transparent_bg = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("options"):
		%Options.visible = !%Options.visible

extends CanvasLayer

@onready var sound_manager = get_tree().get_nodes_in_group("SoundManager")[0]  
@onready var panel = %options_panel
@onready var mouse_inside = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("changed_level", on_changed_level)
	%SoundVolumeSlider.value = sound_manager.get_sound_volume() * 100
	%SoundVolumeValue.text = str(%SoundVolumeSlider.value)
	%VolumeSlider.value = sound_manager.get_music_volume() * 100
	%VolumeValue.text = str(%VolumeSlider.value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_mouse_inside()
	if Input.is_action_just_released("Click"):
		if !mouse_inside && visible:
			visible = false
	
func check_mouse_inside():
	if not Rect2(Vector2(0, 0), panel.size).has_point(panel.get_local_mouse_position()):
		mouse_inside = false
	else:
		mouse_inside = true

func _on_volume_slider_value_changed(value):
	sound_manager.set_music_volume(%VolumeSlider.value / 100)
	%VolumeValue.text = str(%VolumeSlider.value)

func on_changed_level():
	%SoundVolumeSlider.value = sound_manager.get_sound_volume() * 100
	%SoundVolumeValue.text = str(%SoundVolumeSlider.value)
	%VolumeSlider.value = sound_manager.get_music_volume() * 100
	%VolumeValue.text = str(%VolumeSlider.value)


func _on_options_pressed():
	visible = !visible


func _on_sound_volume_slider_changed():
	sound_manager.set_sound_volume(%SoundVolumeSlider.value / 100)
	%SoundVolumeValue.text = str(%SoundVolumeSlider.value)

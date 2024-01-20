extends CanvasLayer

@onready var sound_manager = get_tree().get_nodes_in_group("SoundManager")[0]  

# Called when the node enters the scene tree for the first time.
func _ready():
	%VolumeSlider.value = sound_manager.get_music_volume() * 100
	%VolumeValue.text = str(%VolumeSlider.value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_volume_slider_value_changed(value):
	sound_manager.set_music_volume(%VolumeSlider.value / 100)
	%VolumeValue.text = str(%VolumeSlider.value)

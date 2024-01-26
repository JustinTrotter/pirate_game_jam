extends Node2D
@export var music_1: AudioStream
@export var music_2: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	%SoundManager.set_default_sound_bus("Sound")
	%SoundManager.set_default_music_bus("Music")
	%SoundManager.play_music(music_1)
	%SoundManager.set_music_volume(0.05)
	%SoundManager.set_sound_volume(0.05)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

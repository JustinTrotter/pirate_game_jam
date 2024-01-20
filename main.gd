extends Node2D

@export var music_1: AudioStream
@export var music_2: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	%SoundManager.play_music(music_1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

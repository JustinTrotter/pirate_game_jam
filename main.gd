extends Node2D

@export var title_music: AudioStream
@export var game_music: AudioStream
@export var dead_music: AudioStream

@onready var transition_audio: AudioStream
@onready var pre_transition_volume: float
@onready var transition_volume: float
@onready var is_fading: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	%SoundManager.set_default_sound_bus("Sound")
	%SoundManager.set_default_music_bus("Music")
	%SoundManager.play_music(title_music)
	%SoundManager.set_music_volume(0.05)
	%SoundManager.set_sound_volume(0.05)
	%Curtain.visible = true
	fade_out_curtain()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_fading:
		%SoundManager.set_music_volume(transition_volume)
	
func start_game():
	%"Title Screen".visible = false
	%"UI Screen".visible = true
	%"Game Screen".visible = true
	
func _on_play_pressed():
	transition_music(game_music)
	fade_in_out_curtain()

func transition_music(newSong: AudioStream):
	transition_audio = newSong
	fade_music_out()
	
func fade_music_out():
	pre_transition_volume = %SoundManager.get_music_volume()
	transition_volume = %SoundManager.get_music_volume()
	is_fading = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "transition_volume", 0, 1)
	tween.tween_callback(fade_music_in)
	
func fade_music_in():
	%SoundManager.play_music(transition_audio)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "transition_volume", pre_transition_volume, 1)
	tween.tween_callback(finish_fading)

func finish_fading():
	pass
	
func fade_out_curtain():
	var tween = get_tree().create_tween()
	tween.tween_property(%Curtain, "modulate", Color(0,0,0,0), 1)
	#%Curtain.visible = false
	
func fade_in_out_curtain_callback():
	fade_out_curtain()
	start_game()
	
func fade_in_out_curtain():
	#%Curtain.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(%Curtain, "modulate", Color(0,0,0,1), 1)
	tween.tween_callback(fade_in_out_curtain_callback)

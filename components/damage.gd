extends Node2D

@onready var sound_manager = get_tree().get_nodes_in_group("SoundManager")[0]

@export var damage_sound_fx: AudioStream
@export var min_sound_pitch: float
@export var max_sound_pitch: float

@onready var parent = get_parent();
@onready var health_component;
@onready var armor_component;

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component = parent.find_child("Health")
	armor_component = parent.find_child("Armor")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(value):
	play_damage_sound()
	var damage_value = value
	if armor_component:
		damage_value = armor_component.reduce_damage(value)
	health_component.health -= damage_value


func play_damage_sound():
	var pitch = 1.0
	if min_sound_pitch && max_sound_pitch && min_sound_pitch < max_sound_pitch:
		pitch = Globals.rng.randf_range(min_sound_pitch, max_sound_pitch)
	if damage_sound_fx:
		sound_manager.play_sound_with_pitch(damage_sound_fx, pitch)

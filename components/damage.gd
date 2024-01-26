extends Node2D

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
	var damage_value = value
	if armor_component:
		damage_value = armor_component.reduce_damage(value)
	health_component.health -= damage_value

extends Node2D

@onready var bullet_graphics = [
	load("res://assets/resources/bullet_1.png"),
	load("res://assets/resources/bullet_2.png")
]

@onready var bullet_scenes = [
	preload("res://bundles/game/bullet_A.tscn"),
	preload("res://bundles/game/bullet_B.tscn")
]

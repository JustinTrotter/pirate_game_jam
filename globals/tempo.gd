extends Node2D

@onready var tempo: Timer = Timer.new()
@export var tempo_rate: float

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(tempo)
	tempo.one_shot = false
	tempo.autostart = true
	tempo.wait_time = tempo_rate
	tempo.start()
	tempo.timeout.connect(_tempo_Timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _tempo_Timeout():
	pass
	#Globals.tempo_tick.emit()

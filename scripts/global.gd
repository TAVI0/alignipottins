extends Node

var SCORE = 0
var POTS = []
var SHELVES = 4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_pots_group()
	pass # Replace with function body.

func set_pots_group():
	var numgroup = 0
	for i in SHELVES:
		POTS.append(numgroup)
		POTS.append(numgroup)
		POTS.append(numgroup)
		numgroup+=1
	POTS.shuffle()
	print("POTS GROUP CREADO")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

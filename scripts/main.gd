extends Node2D

@onready var time = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$time/number.set_text(str(int(time.time_left)))
	pass

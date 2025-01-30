extends DropZone

var marker_status: Dictionary = {}
@onready var content = $Content
@onready var markers = $Markers

func _ready() -> void:
	for marker in markers.get_children():
		if marker is Marker2D:
			marker_status[marker] = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends DropZone

var groupList = []
var LONGSET = 3
@onready var markers = $Markers

func _ready() -> void:
	pass

func addToGroupList(group):
	groupList.append(group)
	print(groupList)
	checkSet()

func checkSet():
	if groupList.size() == LONGSET and groupList.count(groupList[0]) == groupList.size():
		completeSet()

func completeSet():
	for marker in markers.get_children():
		var contentMarker = marker.get_child(0)
		if contentMarker.get_child(0)!=null:
			contentMarker.get_child(0).queue_free()
	groupList.clear()
	print(groupList)

func add_decoration(decoration: Draggable):
	await find_a_place(decoration)
	addToGroupList(decoration.group)

func find_a_place(decoration):
	var empty_marker = get_empty_marker()
	if empty_marker != null:
		await move_to_marker(decoration, empty_marker)
		var content_marker=empty_marker.get_child(0)
		decoration.reparent(content_marker)

func move_to_marker(node: Node2D, marker: Marker2D):
	var tween = get_tree().create_tween().tween_property(
		node,
		"global_position",
		marker.global_position,
		0.5
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	await tween.finished


func get_empty_marker():
	for marker in markers.get_children():
		if marker.get_child(0).get_child(0)==null:
			return marker

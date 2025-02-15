extends DropZone

var groupList = []
var LONGSET = 3
@onready var content = $Content
@onready var markers = $Markers
var marker_status: Dictionary = {}

func _ready() -> void:
	for marker in markers.get_children():
		if marker is Marker2D:
			marker_status[marker] = null

func addToGroupList(group):
	groupList.append(group)
	print(groupList)
	checkSet()

func checkSet():
	if groupList.size() == LONGSET and groupList.count(groupList[0]) == groupList.size():
		completeSet()

func completeSet():
	for pot in content.get_children():
		pot.queue_free()
	groupList.clear()
	print(groupList)

func add_decoration(decoration: Draggable):
	decoration.reparent(content)
	decoration.connect("dropped",
		func(_dragged, _overlapping_areas):
			reset_marker_status(_dragged)
			find_a_place(_dragged)
	)
	find_a_place(decoration)
	addToGroupList(decoration.group)

func find_a_place(decoration):
	var empty_marker = get_empty_marker()
	if empty_marker != null:
		move_to_marker(decoration, empty_marker)
		var content_marker=empty_marker.get_child(0)
		decoration.reparent(content_marker)

func move_to_marker(node: Node2D, marker: Marker2D):
	get_tree().create_tween().tween_property(
		node,
		"position",
		marker.position,
		0.5
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	marker_status[marker] = node

func reset_marker_status(decoration: Draggable):
	for marker in marker_status.keys():
		if marker_status[marker] == decoration:
			marker_status[marker] = null
			break

func get_empty_marker():
	for marker in markers.get_children():
		if marker.get_child(0).get_child(0)==null:
			return marker

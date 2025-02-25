extends Area2D
class_name Draggable

const DRAGGIN_SPEED = 50

var initial_position := Vector2.ZERO
var initial_scale := Vector2.ZERO
var is_dragging = false
var texture: Texture

signal dropped(draggable: Draggable, area: Area2D)

@export var group = 0
@onready var sprite = $Sprite
@onready var collision_shape = $CollisionShape

@export_category("Type Settings")
@export_flags_2d_physics var decoration_collisions = 2

func _ready() -> void:
	$AnimatedSprite2D.set_frame_and_progress(group,0)
	if texture:
		sprite.texture = texture
	#initial_position = position
	initial_scale = scale
	self.connect("dropped", _on_successfully_dropped)
	$Label.set_text("group: "+ str(group))
	play_spawn_animation()

func _on_successfully_dropped(decoration: Draggable, area: Area2D):
	if area is DropZone:
		area.add_decoration(decoration)
		
func _process(delta: float) -> void:
	if is_dragging:
		global_position = lerp(
			global_position,
			get_global_mouse_position(),
			delta * DRAGGIN_SPEED
		)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		is_dragging = true
		initial_position = global_position
		move_to_front()
		#set_as_top_level(true)
		
	if event.is_action_released("click"):
		pass


func _input(event: InputEvent) -> void:
	if event.is_action_released("click") and is_dragging:
		is_dragging = false
		var overlapping_areas = get_overlapping_areas()
		if overlapping_areas:
			dropped.emit(self,overlapping_areas[0])
		else:
			return_to_position()
			pass
	pass

func self_destruct():
	await play_self_destruct_animation()
	queue_free()

func return_to_position():
	var tween = get_tree().create_tween().tween_property(
		get_node("."),
		"global_position",
		initial_position,
		0.5
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	await tween.finished

func play_spawn_animation():
	scale = Vector2.ZERO
	get_tree().create_tween()\
	.tween_property(self, "scale", initial_scale,0.3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	
func play_self_destruct_animation():
	await  get_tree().create_tween()\
	.tween_property(self, "scale", Vector2(0.0,0.0), 0.1)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD).finished

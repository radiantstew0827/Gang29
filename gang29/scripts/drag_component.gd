extends Node
class_name DragingComponent
# gives player ability to drag

@export var player_camera : Player
@export var enabled : bool = true
@export var dragged_object : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func drop_object():
	pass

func handle_input() -> void:
	if Input.is_action_just_pressed("Drag"):
		if dragged_object:
			drop_object()
		else:
			pass
	
func move_object() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not enabled or not dragged_object : return
	
	handle_input()
	move_object()
	pass

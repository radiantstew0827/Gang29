extends Node3D
class_name Interactable
signal Click(draggable : Draggable)

var outline_shader : Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func outline(visible_change : bool) -> void:
	if visible_change and outline_shader:
		pass
		#create
	else:
		pass
		#sahder.viasible = visible_change
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

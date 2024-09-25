extends Node3D
class_name Interactable

var outline_shader : Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func outline(visible : bool) -> void:
	if visible and outline:
		pass
		#create
	else:
		pass
		#sahder.viasible = visible
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

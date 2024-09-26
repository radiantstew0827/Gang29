extends Interactable
class_name Draggable

@export var can_be_dragged := true

func destroy_self() -> void:
	var drag_comp : DragingComponent = get_tree().current_scene.get_node("Player").drag_component
	drag_comp.dragged_object = null
	
	call_deferred("queue_free")
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

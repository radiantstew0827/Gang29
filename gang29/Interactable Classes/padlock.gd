extends Interactable
class_name Padlock

@export var key_id : String
@export var door : Door


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_click(draggable : Draggable = null) -> void:
	print("say gex")
	if draggable is not KeyItem: return
	
	if draggable.key_id == key_id:
		door.unlocked = true
		draggable.queue_free()
		queue_free()
		pass
	
	pass # Replace with function body.

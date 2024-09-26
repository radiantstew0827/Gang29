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

func _on_click(draggable : Draggable) -> void:
	print("say gex", draggable)
	if draggable is not KeyItem: return
	print("sesbian lex")
	
	if draggable.key_id == key_id:
		# probs not the best way to do it but fuck it
		door.unlocked = true
		draggable.destroy_self()
		call_deferred("queue_free")
		pass
	
	pass # Replace with function body.

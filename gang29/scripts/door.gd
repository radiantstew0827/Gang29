extends Interactable
class_name Door

@export_category("References")
@export var anim_player: AnimationPlayer
@export var level: Level

@export_category("Variables")
@export var open := false
@export var unlocked := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_click(_draggable) -> void:
	if not unlocked: return
	if open: return
	
	anim_player.play("Open")
	await anim_player.animation_finished
	
	open = true
	level.level_completed.emit()
	
	pass # Replace with function body.

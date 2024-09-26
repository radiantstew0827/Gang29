extends Node3D


@export var levels: Array[PackedScene]
@export var player: Player
@export var current_level: Node3D

@export var level_tween_offset := Vector3(-40,0,0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for level_scene in levels:
		# TO DO: load level
		var level = level_scene.instantiate()
		current_level = level
		player.update_camera()
		add_child(level)
		
		# tween in
		level.global_position += level_tween_offset
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(level, "global_position", level.global_position - level_tween_offset, 2)
		await tween.finished
		
		player.drag_component.enabled = true
		await level.level_completed 
		
		# tween out
		tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(level, "global_position", level.global_position - level_tween_offset, 2)
		tween.tween_callback(level.queue_free)
		player.drag_component.enabled = false
		if player.drag_component.dragged_object:
			player.drag_component.dragged_object.destroy_self()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

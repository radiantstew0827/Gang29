extends Node3D


@export var levels: Array[PackedScene]
@export var player: Camera3D
@export var current_level: Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for level_scene in levels:
		# TO DO: load level
		var level = level_scene.instantiate()
		current_level = level
		add_child(level)
		player.update_camera()
		await level.level_completed # not sure if this works
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

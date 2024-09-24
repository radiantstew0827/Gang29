extends Node3D

@export
var levels: Array[PackedScene]
var player: Camera3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for level in levels:
		# TO DO: load level
		player.update_camera()
		await level.level_completed
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node3D
class_name Level

@export var camera_point : Marker3D
@export var future_room_offset: Vector3 = Vector3(0,2000,0)

@export var present_room: Node3D
@export var future_room: Node3D

signal level_completed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	future_room.position = present_room.position + future_room_offset
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

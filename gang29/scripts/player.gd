extends Camera3D

@export var future_mode : bool = true
@export var current_level_number : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_camera():
	rotation = Vector3(-30,45,0)
	
	var current_level : Level = get_tree().root.get_node("level"+str(current_level_number))
	var camera_point: Vector3
	match future_mode:
		true:
			camera_point = current_level.camera_point.position + current_level.future_room_offset
		false:
			camera_point = current_level.camera_point.position
		
	position = camera_point

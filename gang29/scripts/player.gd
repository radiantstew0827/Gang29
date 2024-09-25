extends Camera3D

@export var future_mode : bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func update_camera():
	rotation = Vector3(deg_to_rad(-45),deg_to_rad(45),0)
	
	var current_level : Level = get_tree().current_scene.current_level
	var camera_point: Vector3
	match future_mode:
		true:
			camera_point = current_level.camera_point.position + current_level.future_room_offset
		false:
			camera_point = current_level.camera_point.position
		
	position = camera_point
	
func _unhandled_input(event):
	if event.is_action_pressed("time_switch"):
		future_mode = not future_mode
		update_camera()
		pass

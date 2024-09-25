extends Camera3D
class_name Player

@export var future_mode : bool = true

var hover_object : Interactable


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if hover_object: hover_object.outline(false)
	
	#======== Interactable detection ===========
	# finds origin and direction
	var viewport := get_viewport()
	var mouse_position := viewport.get_mouse_position()
	var origin := project_ray_origin(mouse_position)
	var direction := project_ray_normal(mouse_position)
	
	# raycast
	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, origin+direction*99)
	var result := space_state.intersect_ray(query)
	
	#FINALLY
	if result.is_empty() or result["collider"] is not Interactable:
		hover_object = null
		return
		
	hover_object = result["collider"]
	hover_object.outline(true)
	
	# then figure the rest out
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

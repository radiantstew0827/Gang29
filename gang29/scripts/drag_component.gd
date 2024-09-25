extends Node
class_name DragingComponent
# gives player ability to drag

@export var player_camera : Player
@export var enabled : bool = true
@export var dragged_object : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func drop_object():
	pass
	
func get_mouse_raycast_result() -> Dictionary:
	# finds origin and direction
	var viewport := get_viewport()
	var mouse_position := viewport.get_mouse_position()
	var origin := player_camera.project_ray_origin(mouse_position)
	var direction := player_camera.project_ray_normal(mouse_position)
	
	# raycast
	var space_state := player_camera.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, origin+direction*99)
	return space_state.intersect_ray(query)

func handle_input() -> void:
	if Input.is_action_just_pressed("Drag"):
		if dragged_object:
			drop_object()
		else: # pick up object
			var mouse_result := get_mouse_raycast_result()
			#FINALLY
			if mouse_result.is_empty() or mouse_result["collider"] is not Interactable:
				dragged_object = null
			else:
				dragged_object = mouse_result["collider"]
	
func move_object() -> void:
	var viewport := get_viewport()
	var mouse_position := viewport.get_mouse_position()
	var origin := player_camera.project_ray_origin(mouse_position)
	var direction := player_camera.project_ray_normal(mouse_position)
	
	dragged_object.global_position = origin + direction * 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not enabled : return
	handle_input()
	
	if not dragged_object: return
	move_object()
	pass

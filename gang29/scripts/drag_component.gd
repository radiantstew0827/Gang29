extends Node
class_name DragingComponent
# gives player ability to ~~drag~~ click
# ye the name "drag" is a bit out dated

@export var player_camera : Player
@export var enabled : bool = true
@export var dragged_object : Draggable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func get_mouse_origin_end() -> Array[Vector3]:
	# finds origin and direction
	var viewport := get_viewport()
	var mouse_position := viewport.get_mouse_position()
	var origin := player_camera.project_ray_origin(mouse_position)
	var direction := player_camera.project_ray_normal(mouse_position)
	return [origin, origin+direction*99]
	
func drop_object():
	# Adjusts key positiuon (so it would be less in the wall, since ray hits its own hitbox)
	var origin_end := get_mouse_origin_end()
	
	var space_state := player_camera.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin_end[0], origin_end[1])
	var result :=  space_state.intersect_ray(query)
	
	print(result)
	if result.is_empty(): return

	dragged_object.global_position = result["position"]
	
	# Moves the key to the floor
	
	query = PhysicsRayQueryParameters3D.create(dragged_object.global_position, Vector3(0,-99,0))
	result =  space_state.intersect_ray(query)
	
	if result.is_empty(): return
	
	dragged_object.global_position = result["position"]
	dragged_object = null

	
func get_hover_mouse() -> Interactable:
	var origin_end := get_mouse_origin_end()

	var space_state := player_camera.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin_end[0], origin_end[1])
	var result =  space_state.intersect_ray(query)
	
	#FINALLY
	#print(result) # thsi was added here so many times, you migth as well keep it
	if result.is_empty() or result["collider"] is not Interactable:
		return null
	else:
		return result["collider"]

func handle_input() -> void:
	if not Input.is_action_just_pressed("Drag"): return
	
	var origin_end := get_mouse_origin_end()

	# raycast
	#NOTE: get_hover_mouse() cannot be used as query needs to ignore the dragged_object
	# alos, this is getting quite spaghettio
	var interactable : Interactable
	if dragged_object:
		var space_state := player_camera.get_world_3d().direct_space_state
		var query := PhysicsRayQueryParameters3D.create(origin_end[0], origin_end[1], 1 ,[dragged_object]) 
		var result =  space_state.intersect_ray(query)
		
		if result.is_empty() or result["collider"] is not Interactable:
			interactable = null
		else:
			interactable = result["collider"]
	else:
		interactable = get_hover_mouse()
	
	# player can interact with an interactable even if dragged_object exists
	if interactable:
		interactable.Click.emit(dragged_object)
		
		if interactable is Draggable:
			dragged_object = interactable
	elif dragged_object:
		drop_object()
			


func move_object() -> void:
	var origin_end := get_mouse_origin_end()
	
	# raycast
	var space_state := player_camera.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin_end[0], origin_end[1], 1 ,[dragged_object]) 
	var result =  space_state.intersect_ray(query)
	
	#FINALLY
	if not result.is_empty():
		dragged_object.global_position = result["position"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not enabled : return
	handle_input()
	
	if not dragged_object: return
	move_object()

extends Camera2D

var target_position = Vector2.ZERO
@export var camera_smoothing_speed = 10                              
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_camera_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * camera_smoothing_speed)) 

func get_camera_target():
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Node2D
		target_position = player.global_position

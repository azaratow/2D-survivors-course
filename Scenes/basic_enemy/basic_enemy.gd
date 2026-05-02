extends CharacterBody2D

@export var max_spoed = 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$hurt_box.area_entered.connect(on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = direction * max_spoed
	move_and_slide()

func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO

func on_area_entered(other_area: Area2D):
	queue_free()

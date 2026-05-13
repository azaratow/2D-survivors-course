extends CharacterBody2D

@export var max_spoed = 60
@onready var HealthComponent: HealthComponent  = $HealthComponent



func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = direction * max_spoed
	move_and_slide()

func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO

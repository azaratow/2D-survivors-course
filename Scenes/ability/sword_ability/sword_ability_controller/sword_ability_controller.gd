extends Node

@export var max_range: float = 95 # set the max range of the attack

@export var sword_ability: PackedScene #create a container for a packed scene in this case for a sword attack scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D   # find the player node in the player GROUP and store it in this variable
	if player == null:   # if the player does not exist do nothing aka return
		return
	
	var enemies = get_tree().get_nodes_in_group("enemy")  # find the enemies within the enemy GROUP and store it in this variable
	enemies = enemies.filter(func(enemy: Node2D): 
		return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range, 2)
	)
	if enemies.size() == 0: # if there are no enemies do nothing aka return 
		return
	
	
	enemies.sort_custom(func(a: Node2D, b: Node2D):  # this will sort enemies and find the closest enemy to player and store it as the first enemy in the array
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	var sword_instance = sword_ability.instantiate() as Node2D # create the sword ability scene and store it in this variable
	player.get_parent().add_child(sword_instance) # spawn the sword in the scene above the player scene
	sword_instance.global_position = enemies[0].global_position  # see line 25.. set the position of the sword attack to be the first enemy aka enemies[0] 
	

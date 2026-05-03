extends CharacterBody2D

@export var max_speed = 125
@export var accelleration_smoothing = 27
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var targert_velocity = direction * max_speed
	
	velocity = velocity.lerp(targert_velocity, 1 - exp(-delta * accelleration_smoothing))
	
	move_and_slide()
	if Input.is_action_pressed("confirm"):
		max_speed = 300
	else:
		max_speed = 150

func get_movement_vector():

	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	return Vector2(x_movement, y_movement)

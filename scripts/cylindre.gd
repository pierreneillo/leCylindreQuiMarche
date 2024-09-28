extends CharacterBody3D


const SPEED = 15 # en m/s
const ROTATION_SPEED = 45 * PI / 180 # en rad/s


func _physics_process(delta: float) -> void:
	
	var sens := 0
	var direction := - transform.basis.z.normalized()
	
	# Gestion du mouvement
	if Input.is_action_pressed("forwards"):
		sens = 1
	elif Input.is_action_pressed("backwards"):
		sens = -1
	if Input.is_action_pressed("left"):
		direction = direction.rotated(Vector3.UP, ROTATION_SPEED * delta)
	elif Input.is_action_pressed("right"):
		direction = direction.rotated(Vector3.UP, -ROTATION_SPEED * delta)
	
	transform.basis = Basis().looking_at(direction,Vector3.UP)
	
	velocity = sens * SPEED  * direction.normalized()
	print(delta,direction)
	move_and_slide()

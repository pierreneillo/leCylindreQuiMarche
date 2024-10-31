extends Camera3D

@export var follow_target : Node3D = null


@export var VERTICAL_ANGLE_DEFAULT : float = 45 # en degrés
@export var V_MAX_ANGLE : float = PI/2
@export var V_MIN_ANGLE : float = 0.01
@export var HORIZONTAL_ANGLE_DEFAULT : float = 0
@export var DIST_DEFAULT : float
@export var DIST_MIN : float = 2
@export var DIST_MAX : float = 10

@export var H_RPS : float = 2 # Rotations horizontales par seconde (en radians)
@export var V_RPS : float = 1.5 # Rotations verticales par seconde (en radians)

var vertical_angle : float # Angle "vertical" de rotation autour de l'axe relatif z du perso
var horizontal_angle = HORIZONTAL_ANGLE_DEFAULT * PI / 180

var DIST_RPS : float # Ne doit pas être modifié à la main, dépend de V_RPS


func _ready() -> void:
	if follow_target == null:
		follow_target = get_node("../cylindre");
	VERTICAL_ANGLE_DEFAULT *= PI / 180
	if DIST_DEFAULT == 0:
		DIST_DEFAULT = DIST_MIN + (DIST_MAX - DIST_MIN) * (VERTICAL_ANGLE_DEFAULT - V_MIN_ANGLE) / (V_MAX_ANGLE - V_MIN_ANGLE)
	elif VERTICAL_ANGLE_DEFAULT == 0:
		VERTICAL_ANGLE_DEFAULT = V_MIN_ANGLE + (V_MAX_ANGLE - V_MIN_ANGLE) * (DIST_DEFAULT - DIST_MIN) / (DIST_MAX - DIST_MIN)	
	else:
		assert((DIST_DEFAULT - DIST_MIN) / (DIST_MAX - DIST_MIN) == (VERTICAL_ANGLE_DEFAULT - V_MIN_ANGLE) / (V_MAX_ANGLE - V_MIN_ANGLE))
	size = DIST_DEFAULT
	vertical_angle = VERTICAL_ANGLE_DEFAULT
	DIST_RPS = (DIST_MAX - DIST_MIN) * V_RPS / (V_MAX_ANGLE - V_MIN_ANGLE);
	rotation = Vector3(-vertical_angle,0,0)
	calc_pos()

func calc_pos():
	# On doit calculer la position de la caméra relativement au cylindre.
	# Les angles de rotation etc doivent être calculés par rapport au *centre* du cylindre
	# On doit récupérer le centre du cylindre:
	var pivot = follow_target.global_position + 2*Vector3.UP
	position = pivot \
		+ size * Vector3(sin(horizontal_angle)*cos(vertical_angle),sin(vertical_angle),cos(horizontal_angle)*cos(vertical_angle))

func _process(delta: float) -> void:
	if Input.is_action_pressed("camera_left"):
		horizontal_angle += H_RPS * delta
		rotate_y(H_RPS*delta)
	if Input.is_action_pressed("camera_right"):
		rotate_y(-H_RPS*delta)
		horizontal_angle -= H_RPS * delta
	if Input.is_action_pressed("camera_down") and vertical_angle >= V_MIN_ANGLE:
		vertical_angle -= V_RPS * delta
		rotate_object_local(Vector3.RIGHT,V_RPS*delta)
		size -= DIST_RPS * delta
	if Input.is_action_pressed("camera_up") and vertical_angle <= V_MAX_ANGLE:
		vertical_angle += V_RPS * delta
		rotate_object_local(Vector3.RIGHT,-V_RPS*delta)
		size += DIST_RPS * delta
		
	calc_pos()

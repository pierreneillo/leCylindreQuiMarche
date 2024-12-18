extends CharacterBody3D

var MORPHS = []
var morph = 0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var cam=null
var dirCam=null





class Morph:
	"""Classe représentant les différentes formes du cylindre.
	L'idée serait de l'utiliser pour avoir des méthodes et attributs standard (qui ne dépendent pas du Morph) mais qui peuvent agir différement:
	Ex: le morph correspondant au cylindre allongé roulant doit faire tourner le perso sur lui-même quand il avance, alors que le cylindre droit non"""

	var name : String = ""
	var speed : int = 0
	var rotation_speed : float = 0
	var speed_incr : int = 0
	var max_speed : int = 0
	var inertia_time = .2


	func _init(_name:String, _speed:int, _rotation_speed:float, _speed_incr:int, _max_speed : int,inertia_time) -> void:
		self.name = _name
		self.speed = _speed
		self.rotation_speed = _rotation_speed
		self.speed_incr = _speed_incr 
		self.max_speed = _max_speed
		self.inertia_time = inertia_time
		
	func move() -> void:
		pass

func _ready():
	print(position)
	position = Vector3(0,5,0)
	cam= get_node("../Camera3D")
	dirCam=cam.position
	const _morphs = {
		"CYLINDER_UPRIGHT" : {
			"MAX_SPEED" : 10,
			"SPEED":0,
			"SPEED_INCR":1, #acceleration
			"ROTATION_SPEED" : 100 * PI/180,
			"INERTIA" : .2
		},
		"CYLINDER_ROLLING" : {
			"MAX_SPEED" : 45,
			"SPEED":0,
			"SPEED_INCR":1, #acceleration
			"ROTATION_SPEED" : 30 * PI/180,
			"INERTIA": 1
		}
	};
	for morph_name in _morphs:
		var m = Morph.new(morph_name,_morphs[morph_name]["SPEED"],_morphs[morph_name]["ROTATION_SPEED"],_morphs[morph_name]["SPEED_INCR"],_morphs[morph_name]["MAX_SPEED"],_morphs[morph_name]["INERTIA"])
		MORPHS.append(m)
	morph = MORPHS[0]

func wheelspawn(delta:float) -> void:
	pass
	
func wheeldespawn(delta:float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("wheel"):
		wheelspawn(delta)
	if Input.is_action_just_released("wheel"):
		wheeldespawn(delta)
	if morph.name == "CYLINDER_UPRIGHT" or morph.name == "CYLINDER_ROLLING":
		var factorfb := 0 # Facteur multiplicatif devant le vecteur de direction avancer/reculer
		var factorlr := 0 # Facteur multiplicatif devant le vecteur de direction gauche/droite
		var directionfb = - cam.transform.basis.z.normalized()
		directionfb=Vector3(directionfb.x,0,directionfb.z)
		var directionlr = directionfb.rotated(Vector3.UP,PI/2)
		var previousDirection=directionfb
		var vy = velocity.y
		# Gestion du mouvement
		if Input.is_action_pressed("forwards"):
			factorfb = 1
		elif Input.is_action_pressed("backwards"):
			factorfb = -1
		if Input.is_action_pressed("left"):
			factorlr = 1
		if Input.is_action_pressed("right"):
			factorlr = -1
		transform.basis = Basis.looking_at(directionfb,Vector3.UP)
		
		var target_velocity = factorfb * morph.max_speed  * directionfb.normalized() + factorlr * morph.max_speed  * directionlr.normalized()
		
		velocity = velocity + (target_velocity - velocity) * delta / morph.inertia_time
		
		if not is_on_floor():
			velocity.y = vy -  gravity * delta
		
		move_and_slide()
		morph.move()
		
	else:
		pass	

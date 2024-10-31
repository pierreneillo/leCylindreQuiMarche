extends CharacterBody3D

var MORPHS = []
var morph = 0

class Morph:
	"""Classe représentant les différentes formes du cylindre.
	L'idée serait de l'utiliser pour avoir des méthodes et attributs standard (qui ne dépendent pas du Morph) mais qui peuvent agir différement:
	Ex: le morph correspondant au cylindre allongé roulant doit faire tourner le perso sur lui-même quand il avance, alors que le cylindre droit non"""

	var name : String = ""
	var speed : int = 0
	var rotation_speed : float = 0


	func _init(_name:String, _speed:int, _rotation_speed:float) -> void:
		self.name = _name
		self.speed = _speed
		self.rotation_speed = _rotation_speed
		
	func move() -> void:
		pass

func _ready():
	const _morphs = {
		"CYLINDER_UPRIGHT" : {
			"SPEED" : 5,
			"ROTATION_SPEED" : 150 * PI/180
		},
		"CYLINDER_ROLLING" : {
			"SPEED" : 15,
			"ROTATION_SPEED" : 30 * PI/180
		}
	};
	for morph_name in _morphs:
		var m = Morph.new(morph_name,_morphs[morph_name]["SPEED"],_morphs[morph_name]["ROTATION_SPEED"])
		MORPHS.append(m)
	morph = MORPHS[0]


func _physics_process(delta: float) -> void:
	
	if morph.name == "CYLINDER_UPRIGHT" :
		# TODO: Changer le système de mouvement (peut-être contrôler l'accélération
		# plutôt que la vitesse) pour rendre le mouvement pus fluide et include de l'inertie
		var sens := 0
		var direction := - transform.basis.z.normalized()
		
		# Gestion du mouvement
		if Input.is_action_pressed("forwards"):
			sens = 1
		elif Input.is_action_pressed("backwards"):
			sens = -1
		if Input.is_action_pressed("left"):
			direction = direction.rotated(Vector3.UP, morph.rotation_speed * delta)
		elif Input.is_action_pressed("right"):
			direction = direction.rotated(Vector3.UP, -morph.rotation_speed * delta)
		
		transform.basis = Basis.looking_at(direction,Vector3.UP)
		
		velocity = sens * morph.speed  * direction.normalized()
		move_and_slide()
		morph.move()
	else:
		pass	

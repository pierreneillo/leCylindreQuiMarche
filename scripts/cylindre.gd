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
	var speed_incr : int = 0
	var max_speed : int = 0
	var inertia_time = .2


	func _init(_name:String, _speed:int, _rotation_speed:float, _speed_incr:int, _max_speed : int) -> void:
		self.name = _name
		self.speed = _speed
		self.rotation_speed = _rotation_speed
		self.speed_incr = _speed_incr 
		self.max_speed = _max_speed
		
	func move() -> void:
		pass

func _ready():
	const _morphs = {
		"CYLINDER_UPRIGHT" : {
			"MAX_SPEED" : 5,
			"SPEED":0,
			"SPEED_INCR":1, #acceleration
			"ROTATION_SPEED" : 150 * PI/180
		},
		"CYLINDER_ROLLING" : {
			"MAX_SPEED" : 15,
			"SPEED":0,
			"SPEED_INCR":1, #acceleration
			"ROTATION_SPEED" : 30 * PI/180
		}
	};
	for morph_name in _morphs:
		var m = Morph.new(morph_name,_morphs[morph_name]["SPEED"],_morphs[morph_name]["ROTATION_SPEED"],_morphs[morph_name]["SPEED_INCR"],_morphs[morph_name]["MAX_SPEED"])
		MORPHS.append(m)
	morph = MORPHS[0]


func _physics_process(delta: float) -> void:
	if morph.name == "CYLINDER_UPRIGHT" :
		# TODO: Changer le système de mouvement (peut-être contrôler l'accélération
		# plutôt que la vitesse) pour rendre le mouvement pus fluide et include de l'inertie
		# mon idée : on va calculer le produit scalaire entre le vecteur direction actuel et celui demandé par le joueur, le signe donnera s'il faut s'arreter ou non
		# ainsi, pour une valeur positive pas d'arret, et pour negative (ou nulle, si le joueur veut simplement s'arreter) il faut faire un arret 
		# un arret signifie une diminution de speed jusqu'a 0 par un increment definit dans _morph
		var sens := 0
		var direction := - transform.basis.z.normalized()
		var previousDirection=direction
		
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
		
		var target_velocity = sens * morph.max_speed  * direction.normalized()
		
		print(target_velocity,velocity)
		velocity = velocity + (target_velocity - velocity) * delta / morph.inertia_time
		
		#var prodScal = previousDirection.dot(sens*direction)
		#if prodScal>0: #meme direction globale
			#if morph.speed<morph.max_speed:
				#morph.speed+=morph.speed_incr
			#velocity = sens * morph.speed  * direction.normalized()
		#elif prodScal<0: #direction globale opposee
			#if morph.speed>0:
				#morph.speed-=morph.speed_incr
			#velocity=morph.speed * previousDirection.normalized()
		#else : #prod scalaire nul
			#if previousDirection==Vector3.ZERO and direction!=Vector3.ZERO: #veut rentrer en mouvement
				#morph.speed+=morph.speed_incr
				#velocity = sens * morph.speed  * direction.normalized()
			#elif previousDirection!=Vector3.ZERO and direction==Vector3.ZERO: #veut s'arreter 
				#morph.speed-=morph.speed_incr
				#velocity=morph.speed*previousDirection.normalized()
			#elif previousDirection!=Vector3.ZERO and direction!=Vector3.ZERO: #vecteurs perpendiculaires
				#morph.speed-=morph.speed_incr
				#velocity=morph.speed*previousDirection.normalized()
		
		move_and_slide()
		morph.move()
	else:
		pass	

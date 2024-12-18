extends Control

const char_per_sec = 30 #Nombre de caractères affichés par seconde
const max_chars_answers = 40 # Nombre maximal de caractères dans une réponse
const spacing = 10 # En px, expace entre les bordures de chaque boite de réponse

var BEING_DISPLAYED = false
var AWAITING_CONFIRMATION = false
var AWAITING_ANSWER = false
var GENERATING_ANSWER = false
var IS_QUESTION = false

signal answered(answer_number:int)
signal confirmed

var actual_chars: float = 0
var answers = null # Pour stocker les réponses possibles
var action = null # Pour stocker l'action suivante (en cas d'affichage simple de texte)

func _ready() -> void:
	hide()
	#display_simple_text("Tarik","Ta condition physique me semble peu adaptée pour certaines de nos contrées, il te faudra aussi remédier à cela.")
	display_question("Tarik","Est-tu familier avec nos coutumes?",[["Oui","display_simple_text","Tarik","Très bien, je t'ai préparé une petite énigme à résoudre, reviens me voir quand tu auras terminé",["hide"]],["Non","display_simple_text","Tarik","Les habitants du pays aiment se poser mutuellement des énigmes, il te faudra sûrement en résoudre au cours de ton périple.", ["display_simple_text","Tarik","Tu verras, parfois les choses ne marchent pas, ne fonctionnent pas, ne te décourage pas et fais tourner tes méninges, je suis persuadé que tu y arriveras.",["display_simple_text","Tarik","Je t'ai préparé une petite énigme à résoudre, reviens me voir quand tu auras terminé",["hide"]]]]])
	# display_question("Tarik","Es-tu familer avec nos coutumes?",[["Bien sûr"],["Non, pas vraiment"]])
	confirmed.connect(_on_confirmed)
	answered.connect(_on_answered)

func display_simple_text(speaker:String, text:String, _action:Array) -> void:
	show()
	$Answers.hide()
	$MainTextContainer/LayoutContainer/SpeakerName.text = speaker
	$MainTextContainer/LayoutContainer/Text.text = text
	$MainTextContainer/LayoutContainer/Text.visible_characters = 0
	action = _action
	print(action)
	actual_chars = 0
	IS_QUESTION = false
	AWAITING_CONFIRMATION = false
	BEING_DISPLAYED = true

func display_question(speaker: String,text : String,options:Array):
	show()
	$Answers.hide()
	$MainTextContainer/LayoutContainer/SpeakerName.text = speaker
	$MainTextContainer/LayoutContainer/Text.text = text
	$MainTextContainer/LayoutContainer/Text.visible_characters = 0
	IS_QUESTION = true
	AWAITING_ANSWER = false
	BEING_DISPLAYED = true
	answers = options
	print(answers)

func generate_answers():
	# On arrange les réponse comme ça nous arrange (nombre et texte)
	var n = len(answers)
	if n > 4:
		push_error("Nombre de réponses possibles limité à 4")
		assert(false)
	var h = $Answers.size[1]
	var answerHeightRatio = (h - (n-1) * spacing) / n / h
	for i in range(n):
		var answerBox = get_node("Answers/Answer" + str(i+1))
		var textLabel = get_node("Answers/Answer"+str(i+1)+"/RichTextLabel")
		if len(answers[i][0]) > max_chars_answers:
			push_error("Nombre de caractères dans une réponse limités à "+ str(max_chars_answers))
			assert(false)
		else:
			textLabel.text = answers[i][0]
			answerBox.anchor_top = i * (answerHeightRatio + spacing/h)
			answerBox.anchor_bottom = i * (answerHeightRatio + spacing/h) + answerHeightRatio
		answerBox.show()
	for i in range(n,4):
		get_node("Answers/Answer" + str(i+1)).hide()
	$Answers.show()

func _on_answered(answer_num):
	AWAITING_ANSWER = false
	print(answer_num)
	if answer_num < len(answers) and len(answers[answer_num]) > 1:
		# There is a callable
		callv(answers[answer_num][1],answers[answer_num].slice(2))
	# Else we exit
	
func _on_confirmed():
	if AWAITING_CONFIRMATION:
		AWAITING_CONFIRMATION = false
		if action:
			print(action)
			print("Calling next action")
			# There is a callable
			if len(action) >= 2:
				# There is a paramter or more
				callv(action[0],action.slice(1))
			else:
				call(action[0])
		else:
			# Else we exit
			print("Exiting chat")
			hide()
		
	elif BEING_DISPLAYED:
		# On affiche tout
		$MainTextContainer/LayoutContainer/Text.visible_characters = -1
		BEING_DISPLAYED = false
		if IS_QUESTION:
			generate_answers()
			AWAITING_ANSWER = true
		else:
			AWAITING_CONFIRMATION = true

func _process(delta: float) -> void:
	if BEING_DISPLAYED:
		actual_chars += char_per_sec * delta
		$MainTextContainer/LayoutContainer/Text.visible_characters = int(actual_chars)
		if $MainTextContainer/LayoutContainer/Text.visible_characters > len($MainTextContainer/LayoutContainer/Text.text) or Input.is_action_pressed("ui_accept"):
			$MainTextContainer/LayoutContainer/Text.visible_characters = -1
			BEING_DISPLAYED = false
			if IS_QUESTION:
				generate_answers()
				AWAITING_ANSWER = true
			else:
				AWAITING_CONFIRMATION = true

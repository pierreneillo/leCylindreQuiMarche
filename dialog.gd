extends Control

const char_per_sec = 30 #Nombre de caractères affichés par seconde
const max_chars_answers = 40 # Nombre maximal de caractères dans une réponse
const spacing = 10 # En px, expace entre les bordures de chaque boite de réponse

var BEING_DISPLAYED = false
var AWAITING_CONFIRMATION = false
var AWAITING_ANSWER = false
var GENERATING_ANSWER = false
var IS_QUESTION = false

var actual_chars: float = 0

var answers = null

func _ready() -> void:
	hide()
	#display_simple_text("Tarik","Ta condition physique me semble peu adaptée pour certaines de nos contrées, il te faudra aussi remédier à cela.")
	display_question("Tarik","Es-tu familer avec nos coutumes?",["Bien sûr","Non, pas vraiment"])

func display_simple_text(speaker:String, text:String) -> void:
	show()
	$Answers.hide()
	$MainTextContainer/LayoutContainer/SpeakerName.text = speaker
	$MainTextContainer/LayoutContainer/Text.text = text
	$MainTextContainer/LayoutContainer/Text.visible_characters = 0
	actual_chars = 0
	IS_QUESTION = false
	AWAITING_CONFIRMATION = false
	BEING_DISPLAYED = true

func display_question(speaker: String,text : String,options:Array[String]):
	show()
	$Answers.hide()
	$MainTextContainer/LayoutContainer/SpeakerName.text = speaker
	$MainTextContainer/LayoutContainer/Text.text = text
	$MainTextContainer/LayoutContainer/Text.visible_characters = 0
	IS_QUESTION = true
	AWAITING_ANSWER = false
	BEING_DISPLAYED = true
	answers = options
	

func _process(delta: float) -> void:
	if BEING_DISPLAYED:
		print($MainTextContainer/LayoutContainer/Text.text)
		actual_chars += char_per_sec * delta
		$MainTextContainer/LayoutContainer/Text.visible_characters = int(actual_chars)
		if $MainTextContainer/LayoutContainer/Text.visible_characters > len($MainTextContainer/LayoutContainer/Text.text) or Input.is_action_pressed("ui_accept"):
			$MainTextContainer/LayoutContainer/Text.visible_characters = -1
			BEING_DISPLAYED = false
			if IS_QUESTION:
				GENERATING_ANSWER = true
			else:
				AWAITING_CONFIRMATION = true
	elif GENERATING_ANSWER:
		# On arrange les réponse comme ça nous arrange (nombre et texte)
		print(answers)
		var n = len(answers)
		if n > 4:
			push_error("Nombre de réponses possibles limité à 4")
			assert(false)
		var h = $Answers.size[1]
		var answerHeightRatio = (h - (n-1) * spacing) / n / h
		print($Answers.size)
		for i in range(n):
			var answerBox = get_node("Answers/Answer" + str(i+1))
			var textLabel = get_node("Answers/Answer"+str(i+1)+"/RichTextLabel")
			if len(answers[i]) > max_chars_answers:
				push_error("Nombre de caractères dans une réponse limités à "+ str(max_chars_answers))
				assert(false)
			else:
				textLabel.text = answers[i]
				answerBox.anchor_top = i * (answerHeightRatio + spacing/h)
				answerBox.anchor_bottom = i * (answerHeightRatio + spacing/h) + answerHeightRatio
			print(i,": ",textLabel.text)
			answerBox.show()
		for i in range(n,4):
			get_node("Answers/Answer" + str(i+1)).hide()
		$Answers.show()
		GENERATING_ANSWER = false
		AWAITING_ANSWER = true
	elif AWAITING_ANSWER:
		# On attend l'input
		pass

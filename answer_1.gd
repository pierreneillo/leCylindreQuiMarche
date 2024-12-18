extends Panel

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				print("ANSWER 111111")
				$".".get_parent().get_parent().answered.emit(1)

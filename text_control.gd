extends Control

signal mouse_up

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				await mouse_up
				$".".get_parent().confirmed.emit()
			else:
				mouse_up.emit()

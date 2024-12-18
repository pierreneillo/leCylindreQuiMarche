extends Control

signal mouse_down

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				await mouse_down
				$".".get_parent().confirmed.emit()
			else:
				mouse_down.emit()

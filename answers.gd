extends Panel

signal mouse_up

func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	var panel_rect = Rect2(global_position, size)
	if panel_rect.has_point(mouse_pos) and visible:
		print("Event in the box")
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					await mouse_up
					$".".get_parent().get_parent().answered.emit(int(name.substr(name.length())))
				else:
					mouse_up.emit()

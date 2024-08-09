extends Sprite2D

signal clicked

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if is_pixel_opaque(get_local_mouse_position()):
			emit_signal("clicked")

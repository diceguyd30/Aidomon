extends Area2D

signal clicked

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		print("You Clicked Me!")
		emit_signal("clicked")

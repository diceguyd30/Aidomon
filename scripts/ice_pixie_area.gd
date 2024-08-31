extends Area2D

signal clicked
@onready var ice_pixie: AnimatedSprite2D = %ice_pixie

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("click", true) and event.is_pressed() and not event.is_echo():
		print("You Clicked Me!")
		clicked.emit()

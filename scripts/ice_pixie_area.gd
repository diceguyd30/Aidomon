extends Area2D

signal clicked
@onready var ice_pixie = %ice_pixie

func _process(delta):
	ice_pixie.position.x -= 5 * delta

func _on_input_event(_viewport, event, _shape_idx):
	if Input.is_action_just_pressed("click", true) and event.is_pressed() and not event.is_echo():
		print("You Clicked Me!")
		emit_signal("clicked")

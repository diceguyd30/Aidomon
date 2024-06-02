extends Area2D

signal clicked
@onready var ice_pixie = %ice_pixie

func _process(delta):
	ice_pixie.position.x -= 5 * delta

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		print("You Clicked Me!")
		emit_signal("clicked")

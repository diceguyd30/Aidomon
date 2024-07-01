class_name StartingTown
extends Control

@onready var wilderness_outline: ColorRect = %WildernessOutline
@onready var wilderness_label: Label = %WildernessLabel
@onready var wilderness_panel: PanelContainer = %WildernessPanel

func _on_wilderness_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	_update_opacity(1.0)

func _on_wilderness_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	_update_opacity(.7)

func _update_opacity(opacity_: float) -> void:
	wilderness_label.modulate.a = opacity_
	var shader: ShaderMaterial = wilderness_outline.material
	var color: Color = shader.get_shader_parameter("color")
	color.a = opacity_
	shader.set_shader_parameter("color", color)


func _on_wilderness_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			print("better")
		if Input.is_action_just_pressed("click"):
			wilderness_panel.visible = ! wilderness_panel.visible

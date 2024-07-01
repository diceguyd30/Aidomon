class_name StartingTown
extends Control

@onready var wilderness_outline: ColorRect = %WildernessOutline
@onready var wilderness_label: Label = %WildernessLabel


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

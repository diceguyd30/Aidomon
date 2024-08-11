class_name StartingTown
extends Control

@onready var wilderness_label: Label = %WildernessLbl
@onready var craftbench_lbl: Label = %CraftbenchLbl
@onready var wilderness_panel: PanelContainer = %WildernessPanel
@onready var craftbench_panel: PanelContainer = %CraftbenchPanel

func _on_wilderness_btn_mouse_entered() -> void:
	wilderness_label.modulate.a = 1.0

func _on_wilderness_btn_mouse_exited() -> void:
	wilderness_label.modulate.a = .7

func _on_wilderness_btn_toggled(toggled_on: bool) -> void:
	wilderness_panel.visible = toggled_on

func _on_craftbench_btn_mouse_entered() -> void:
	craftbench_lbl.modulate.a = 1.0

func _on_craftbench_btn_mouse_exited() -> void:
	craftbench_lbl.modulate.a = .7

func _on_craftbench_btn_toggled(toggled_on: bool) -> void:
	craftbench_panel.visible = toggled_on


class_name StartingTown
extends Control

@onready var wilderness_panel: PanelContainer = %WildernessPanel
@onready var craftbench_panel: PanelContainer = %CraftbenchPanel

func _on_wilderness_map_location_toggled(toggled_on: bool) -> void:
	wilderness_panel.visible = toggled_on

func _on_craftbench_map_location_toggled(toggled_on: bool) -> void:
	craftbench_panel.visible = toggled_on

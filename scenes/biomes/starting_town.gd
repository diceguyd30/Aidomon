class_name StartingTown
extends Control

@export var biome_data: BiomeData:
	set(value):
		biome_data = value
		_update()

@onready var wilderness_container: MarginContainer = %WildernessContainer
@onready var craftbench_container: MarginContainer = %CraftbenchContainer

func _on_wilderness_map_location_toggled(toggled_on: bool) -> void:
	wilderness_container.visible = toggled_on

func _on_craftbench_map_location_toggled(toggled_on: bool) -> void:
	craftbench_container.visible = toggled_on

func _update() -> void:
	pass

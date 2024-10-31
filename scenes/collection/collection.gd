@tool
class_name Collection
extends Control

@export var collection: Array[SpeciesData]:
	set(value):
		collection = value
		_update_collection()

@onready var collection_grid: GridContainer = %CollectionGrid

const UTIL = preload("res://scripts/util.gd")
const CREATURE_INV_UI = preload("res://scenes/common/creature_inv_ui.tscn")

func _ready() -> void:
	_update_collection()

func _update_collection() -> void:
	if collection_grid == null:
		return
	UTIL.clear_children(collection_grid)
	collection.map(
		func(x: SpeciesData) -> void:
			var slot: CreatureInvUi = CREATURE_INV_UI.instantiate().with_data(x)
			collection_grid.add_child(slot)
	)

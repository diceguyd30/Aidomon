extends Node

const Constants = preload("res://scripts/constants.gd")
const CODEX = preload("res://resources/codex.tres")

var player_inventory_size: int = 10:
	set(value):
		player_inventory_size = value
		player_inventory.max_inventory_size = player_inventory_size
var player_inventory: InventoryData = InventoryData.new().of_size(player_inventory_size)
var biome_unlocks: BiomeUnlocks = BiomeUnlocks.new()
var aidomon_collection: Array[Creature] = []
var current_biome: BiomeData

func _ready() -> void:
	add_to_group(Constants.PERSIST_GROUP)

func save() -> Dictionary[String, Variant]:
	var save_data: Dictionary[String, Variant] = {
		"player_inventory_size" : player_inventory_size,
		"inventory_items": player_inventory.serialize(),
		"biome_unlocks": biome_unlocks.unlock_map,
		"aidomon_collection": aidomon_collection,
	}
	return save_data

func load(save_data: Dictionary[String, Variant]) -> void:
	player_inventory_size = save_data["player_inventory_size"]
	player_inventory.deserialize(save_data["inventory_items"])
	biome_unlocks.deserialize(save_data["biome_unlocks"])
	aidomon_collection.assign(save_data["aidomon_collection"])

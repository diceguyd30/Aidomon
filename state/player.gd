extends Node

const Constants = preload("res://scripts/constants.gd")

var player_inventory_size: int = 10
var player_inventory: InventoryData = InventoryData.new().of_size(player_inventory_size)
var biome_unlocks: BiomeUnlocks = BiomeUnlocks.new()
var aidomon_collection: Array[Creature] = []

func _ready() -> void:
	add_to_group(Constants.PERSIST_GROUP)

func save() -> Dictionary[String, Variant]:
	var save_data: Dictionary[String, Variant] = {
		"player_inventory_size" : player_inventory_size,
		"inventory_items": player_inventory.inventory_items,
		"biome_unlocks": biome_unlocks,
		"aidomon_collection": aidomon_collection,
	}
	return save_data

func load(save_data: Dictionary[String, Variant]) -> void:
	player_inventory_size = save_data["player_inventory_size"]
	player_inventory = InventoryData.new().of_size(player_inventory_size)
	player_inventory.inventory_items = save_data["inventory_items"]
	biome_unlocks = save_data["biome_unlocks"]
	aidomon_collection = save_data["aidomon_collection"]

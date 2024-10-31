extends Node

const Constants = preload("res://scripts/constants.gd")

var player_inventory_size: int = 10:
	set(value):
		player_inventory_size = value
		player_inventory.max_inventory_size = player_inventory_size
var player_inventory: InventoryData = InventoryData.new().of_size(player_inventory_size)
var biome_unlocks: BiomeUnlocks = BiomeUnlocks.new()
var aidomon_collection: Array[SpeciesData] = []
var current_biome: BiomeData

func _ready() -> void:
	add_to_group(Constants.PERSIST_GROUP)

func save() -> Dictionary[Constants.SaveDataIDs, Variant]:
	var save_data: Dictionary[Constants.SaveDataIDs, Variant] = {
		Constants.SaveDataIDs.PLAYER_INVENTORY_SIZE : player_inventory_size,
		Constants.SaveDataIDs.INVENTORY_ITEMS: player_inventory.serialize(),
		Constants.SaveDataIDs.BIOME_UNLOCKS: biome_unlocks.unlock_map,
		Constants.SaveDataIDs.AIDOMON_COLLECTION: aidomon_collection,
	}
	return save_data

func load(save_data: Dictionary[Constants.SaveDataIDs, Variant]) -> void:
	player_inventory_size = save_data[Constants.SaveDataIDs.PLAYER_INVENTORY_SIZE]
	player_inventory.deserialize(save_data[Constants.SaveDataIDs.INVENTORY_ITEMS])
	biome_unlocks.deserialize(save_data[Constants.SaveDataIDs.BIOME_UNLOCKS])
	aidomon_collection.assign(save_data[Constants.SaveDataIDs.AIDOMON_COLLECTION])

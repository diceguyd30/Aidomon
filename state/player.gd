extends Node

const Constants = preload("res://scripts/constants.gd")

var player_inventory: InventoryData = InventoryData.new().of_size(10)
var biome_unlocks: BiomeUnlocks = BiomeUnlocks.new()
var aidomon_collection: Array[Creature] = []

func _ready() -> void:
	add_to_group(Constants.PERSIST_GROUP)

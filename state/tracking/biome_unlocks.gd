class_name BiomeUnlocks
extends RefCounted

enum UnlockIDs {
	WILDERNESS,
	CRAFTING,
}

var unlock_map: Dictionary[UnlockIDs, bool] = {
	UnlockIDs.WILDERNESS: true,
	UnlockIDs.CRAFTING: false,
}

func unlock(unlock_: Unlock) -> void:
	unlock_map[unlock_.id] = true

func deserialize(data: Dictionary) -> void:
	for item: String in data:
		var key := int(item) as UnlockIDs
		unlock_map[key] = data[item]

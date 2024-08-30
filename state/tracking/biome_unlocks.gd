class_name BiomeUnlocks
extends RefCounted

enum UnlockIDs {
	WILDERNESS,
	CRAFTING,
}

var unlock_map: Dictionary = {
	UnlockIDs.WILDERNESS: true,
	UnlockIDs.CRAFTING: false,
}

func unlock(unlock_: Unlock) -> void:
	unlock_map[unlock_.id] = true

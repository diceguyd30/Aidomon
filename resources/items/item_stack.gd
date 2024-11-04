class_name ItemStack
extends Resource

@export var item: ItemData = null
@export var count: int = 0

func serialize() -> Dictionary:
	return {
		"item_id": item.id if item != null else -1,
		"count": count
	}

func deserialize(data: Dictionary) -> void:
	if data.item_id != -1:
		self.item = Game.CODEX.item_list[data.item_id].duplicate()
	self.count = data.count

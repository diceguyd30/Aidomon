class_name ItemStack
extends Resource

@export var item: Item = null
@export var count: int = 0

func serialize() -> Dictionary:
	return {
		"item_id": item.id if item != null else -1,
		"count": count
	}

static func deserialize(data: Dictionary) -> ItemStack:
	var new_stack := ItemStack.new()
	if data.item_id != -1:
		new_stack.item = Game.CODEX.item_list[data.item_id].duplicate()
	new_stack.count = data.count
	return new_stack

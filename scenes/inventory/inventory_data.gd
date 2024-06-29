class_name InventoryData
extends Resource

var max_inventory_size: int = 10

# Ordered inventory items as they should appear in the UI
var inventory_items: Array[ItemStack] = []

class _InventoryMetadata:
	var item_count: int = 0
	# Dictionary<inventory_index: true>  Used as a Set
	var index_map: Dictionary
	
# Dictionary<ItemID: _InventoryMetadata>
var inventory_metadata_map: Dictionary = {}

func _init() -> void:
	var empty_item: ItemStack = ItemStack.new()
	inventory_items.resize(max_inventory_size)
	inventory_items.fill(empty_item)

func add_item_stack(item_stack_: ItemStack) -> ItemStack:
	var metadata: _InventoryMetadata = inventory_metadata_map.find_key(item_stack_.item.id)
	if metadata == null:
		return _add_new_item_stack(item_stack_)	
	return _update_existing_item_stack(metadata, item_stack_)	
	
func _add_new_item_stack(item_stack_: ItemStack) -> ItemStack:
	var empty_index: int = _find_first_empty_slot_index()
	if empty_index == -1:
		return item_stack_
	inventory_items[empty_index] = item_stack_
	var new_metadata: _InventoryMetadata = _InventoryMetadata.new()
	new_metadata.index_map[empty_index] = true
	inventory_metadata_map[item_stack_.item.id] = new_metadata
	return null
	
func _find_first_empty_slot_index() -> int:
	return inventory_items.find(func(i: ItemStack) -> bool: return i.item == null)
	
func _update_existing_item_stack(metadata_: _InventoryMetadata, item_stack_: ItemStack) -> ItemStack:
	metadata_.item_count  += item_stack_.count
	var needed_stacks: float = metadata_.item_count / float(item_stack_.item.max_stack_size)
	if needed_stacks > metadata_.index_map.keys().size():
		pass
	return null

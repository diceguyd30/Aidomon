class_name InventoryManager
extends Object

var inventory_data: InventoryData

static func load_with_inventory(inventory_data_: InventoryData = null) -> InventoryManager:
	var inventory_manager: InventoryManager = InventoryManager.new()
	if inventory_data_ == null:
		inventory_manager.inventory_data = InventoryData.new()
		var empty_item: ItemStack = ItemStack.new()
		inventory_manager.inventory_data.inventory_items.resize(inventory_manager.inventory_data.max_inventory_size)
		inventory_manager.inventory_data.inventory_items.fill(empty_item)
	else:
		inventory_manager.inventory_data = inventory_data_
	return inventory_manager

func add_item_stack(item_stack_: ItemStack) -> ItemStack:
	var metadata: InventoryData._InventoryMetadata = \
		self.inventory_data.inventory_metadata_map.find_key(item_stack_.item.id)
	if metadata == null:
		return _add_new_item_stack(item_stack_)	
	return _update_existing_item_stack(metadata, item_stack_)	
	
func _add_new_item_stack(item_stack_: ItemStack) -> ItemStack:
	var empty_index: int = _find_first_empty_slot_index()
	if empty_index == -1:
		return item_stack_
	self.inventory_data.inventory_items[empty_index] = item_stack_
	var new_metadata: InventoryData._InventoryMetadata = InventoryData._InventoryMetadata.new()
	new_metadata.index_map[empty_index] = true
	self.inventory_data.inventory_metadata_map[item_stack_.item.id] = new_metadata
	return null
	
func _find_first_empty_slot_index() -> int:
	for i: int in self.inventory_data.inventory_items.size():
		if self.inventory_data.inventory_items[i].item == null:
			return i
	return -1
	
func _update_existing_item_stack(
		metadata_: InventoryData._InventoryMetadata, 
		item_stack_: ItemStack) -> ItemStack:
	metadata_.item_count  += item_stack_.count
	var needed_stacks: float = metadata_.item_count / float(item_stack_.item.max_stack_size)
	if needed_stacks > metadata_.index_map.keys().size():
		pass
	return null

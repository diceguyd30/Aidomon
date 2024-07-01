class_name InventoryManager
extends Object

# Represents behaviors that can be taken on an InventoryData resource.

var inventory_data: InventoryData

static func load_with_inventory(inventory_data_: InventoryData = null) -> InventoryManager:
	var inventory_manager: InventoryManager = InventoryManager.new()
	if inventory_data_ == null:
		inventory_manager.inventory_data = create_new_inventory_data()
	else:
		inventory_manager.inventory_data = inventory_data_
	return inventory_manager

static func create_new_inventory_data(max_inventory_size_: int = -1) -> InventoryData:
	var new_inventory: InventoryData = InventoryData.new()
	if max_inventory_size_ > 0:
		new_inventory.max_inventory_size = max_inventory_size_
	var empty_item: ItemStack = ItemStack.new()
	new_inventory.inventory_items.resize(new_inventory.max_inventory_size)
	new_inventory.inventory_items.fill(empty_item)
	var empty_metadata: InventoryData._InventoryMetadata = InventoryData._InventoryMetadata.new()
	var metadata_map: Dictionary = {}
	for i: int in new_inventory.inventory_items.size():
		metadata_map[i] = true
	empty_metadata.index_map = metadata_map
	new_inventory.inventory_metadata_map[null] = empty_metadata
	return new_inventory

func add_item_bundle(item_bundle_: ItemBundle) -> ItemBundle:
	var result: ItemBundle = ItemBundle.new()
	for item in item_bundle_.item_list:
		var overflow: ItemStack = add_item_stack(item.duplicate())
		if overflow != null:
			result.item_list.append(overflow)
	if result.item_list.size() > 0:
		return result
	return null

func add_item_stack(item_stack_: ItemStack) -> ItemStack:
	var metadata: InventoryData._InventoryMetadata = \
		self.inventory_data.inventory_metadata_map.get(item_stack_.item.id)
	if metadata == null:
		var empty_dict: Dictionary = self.inventory_data.inventory_metadata_map[null].index_map
		if empty_dict.size() < 1:
			print("Inventory is full and does not already contain %s. It cannot be added." \
				 % item_stack_.item.name)
			return item_stack_
		return _add_or_return_item_stack(item_stack_)
	return _update_existing_item_stack(metadata, item_stack_)	

func _add_or_return_item_stack(item_stack_: ItemStack) -> ItemStack:
	var result_item_stack: ItemStack = _add_new_item_stack(item_stack_)
	if result_item_stack == null or result_item_stack == item_stack_:
		return result_item_stack
	else:
		return add_item_stack(result_item_stack)

func _add_new_item_stack(item_stack_: ItemStack) -> ItemStack:
	var empty_index: int = _find_first_empty_slot_index()
	if empty_index == -1:
		print("Inventory is full! Cannot add %s" % item_stack_.item.name)
		return item_stack_
	var result: ItemStack = _update_and_return_overflow_item_stack(item_stack_)
	self.inventory_data.inventory_items[empty_index] = item_stack_
	_update_or_create_new_metadata(item_stack_, empty_index)
	self.inventory_data.inventory_metadata_map[null].index_map.erase(empty_index)
	return result

func _find_first_empty_slot_index() -> int:
	for i: int in self.inventory_data.inventory_items.size():
		if self.inventory_data.inventory_items[i].item == null:
			return i
	return -1

func _update_existing_item_stack(
		metadata_: InventoryData._InventoryMetadata, 
		item_stack_: ItemStack) -> ItemStack:
	var needs_to_be_added: int = item_stack_.count
	for i: int in metadata_.index_map.keys():
		needs_to_be_added = _pack_existing_item_stack(inventory_data.inventory_items[i], needs_to_be_added)
		if needs_to_be_added <= 0:
			break
	if needs_to_be_added > 0:
		var new_item_stack: ItemStack = ItemStack.new()
		new_item_stack.item = item_stack_.item
		new_item_stack.count = needs_to_be_added
		return _add_or_return_item_stack(new_item_stack)
	return null

func _pack_existing_item_stack(item_stack_: ItemStack, items_to_pack_: int) -> int:
	var items_to_max: int = item_stack_.item.max_stack_size - item_stack_.count
	if items_to_max > items_to_pack_:
		item_stack_.count += items_to_pack_
		inventory_data.inventory_metadata_map[item_stack_.item.id].item_count += items_to_pack_
		return 0
	else:
		item_stack_.count = item_stack_.item.max_stack_size
		inventory_data.inventory_metadata_map[item_stack_.item.id].item_count \
				+= (item_stack_.item.max_stack_size - item_stack_.count)
		return items_to_pack_ - items_to_max

func _update_and_return_overflow_item_stack(item_stack_: ItemStack) -> ItemStack:
	var result: ItemStack = null
	if (item_stack_.count > item_stack_.item.max_stack_size):
		result = ItemStack.new()
		result.item = item_stack_.item
		result.count = item_stack_.count - item_stack_.item.max_stack_size
		item_stack_.count = item_stack_.item.max_stack_size
	return result

func _update_or_create_new_metadata(item_stack_:ItemStack, index_:int) -> void:
	if self.inventory_data.inventory_metadata_map.has(item_stack_.item.id):
		var metadata: InventoryData._InventoryMetadata = \
				self.inventory_data.inventory_metadata_map[item_stack_.item.id]
		metadata.item_count += item_stack_.count
		metadata.index_map[index_] = true
	else:
		var new_metadata: InventoryData._InventoryMetadata = InventoryData._InventoryMetadata.new()
		new_metadata.item_count = item_stack_.count
		new_metadata.index_map[index_] = true
		self.inventory_data.inventory_metadata_map[item_stack_.item.id] = new_metadata
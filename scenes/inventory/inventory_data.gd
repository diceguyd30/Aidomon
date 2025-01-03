class_name InventoryData
extends Resource

@export var max_inventory_size: int = 10:
	set(value):
		max_inventory_size = value
		_initialze_inventory()
# Ordered inventory items as they should appear in the UI
@export var inventory_items: Array[ItemStack] = []:
	set(value):
		_initialze_inventory(value)
# Dictionary<ItemID: _InventoryMetadata>
var inventory_metadata_map: Dictionary[int, _InventoryMetadata] = {}

class _InventoryMetadata:
	var item_count: int = 0
	# Dictionary<inventory_index: true>  Used as a Set
	var index_map: Dictionary

func of_size(max_inventory_size_: int) -> InventoryData:
	max_inventory_size = max_inventory_size_
	return self

func add_item_bundle(item_bundle_: ItemBundle) -> ItemBundle:
	var result: ItemBundle = ItemBundle.new()
	for item in item_bundle_.item_list:
		var overflow: ItemStack = _add_item_stack(item.duplicate())
		if overflow != null:
			result.item_list.append(overflow)
	if result.item_list.size() > 0:
		return result
	GameSignals.inventory_updated()
	return null

func has_all(item_bundle_: ItemBundle) -> bool:
	return item_bundle_.item_list.all(func(x: ItemStack) -> bool: return has_enough(x))

func has_enough(item_stack_: ItemStack) -> bool:
	if !inventory_metadata_map.has(item_stack_.item.id):
		return false
	return inventory_metadata_map[item_stack_.item.id].item_count >= item_stack_.count

func remove_item_bundle(item_bundle_: ItemBundle) -> ItemBundle:
	var result: ItemBundle = ItemBundle.new()
	for item in item_bundle_.item_list:
		var overflow: ItemStack = _remove_item_stack(item)
		if overflow != null:
			result.item_list.append(overflow)
	GameSignals.inventory_updated()
	if result.item_list.size() > 0:
		return result
	return null

func _initialze_inventory(starting_items_: Array[ItemStack] = []) -> void:
	if max_inventory_size <= 0:
		return
	var empty_item: ItemStack = ItemStack.new()
	inventory_items.resize(max_inventory_size)
	inventory_items.fill(empty_item)
	for i: int in min(inventory_items.size(), starting_items_.size()):
		inventory_items[i] = starting_items_[i]
	_initialize_metadata_map()

func _initialize_metadata_map() -> void:
	for i: int in inventory_items.size():
		var item_: ItemStack = inventory_items[i]
		var id_: Variant
		if item_.item == null:
			id_ = -1
		else:
			id_ = item_.item.id
		if inventory_metadata_map.has(id_):
			inventory_metadata_map[id_].item_count += item_.count
			inventory_metadata_map[id_].index_map[i] = true
		else:
			var new_metadata: _InventoryMetadata = _InventoryMetadata.new()
			new_metadata.item_count += item_.count
			var index_map: Dictionary = {}
			index_map[i] = true
			new_metadata.index_map = index_map
			inventory_metadata_map[id_] = new_metadata

func _add_item_stack(item_stack_: ItemStack) -> ItemStack:
	var metadata: InventoryData._InventoryMetadata = \
		inventory_metadata_map.get(item_stack_.item.id)
	if metadata == null:
		var empty_dict: Dictionary = inventory_metadata_map[-1].index_map
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
		return _add_item_stack(result_item_stack)

func _add_new_item_stack(item_stack_: ItemStack) -> ItemStack:
	var empty_index: int = _find_first_empty_slot_index()
	if empty_index == -1:
		print("Inventory is full! Cannot add %s" % item_stack_.item.name)
		return item_stack_
	var result: ItemStack = _update_and_return_overflow_item_stack(item_stack_)
	inventory_items[empty_index] = item_stack_
	_update_or_create_new_metadata(item_stack_, empty_index)
	inventory_metadata_map[-1].index_map.erase(empty_index)
	return result

func _find_first_empty_slot_index() -> int:
	for i: int in inventory_items.size():
		if inventory_items[i].item == null:
			return i
	return -1

func _update_existing_item_stack(
		metadata_: InventoryData._InventoryMetadata, 
		item_stack_: ItemStack) -> ItemStack:
	var needs_to_be_added: int = item_stack_.count
	for i: int in metadata_.index_map.keys():
		needs_to_be_added = _pack_existing_item_stack(inventory_items[i], needs_to_be_added)
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
		inventory_metadata_map[item_stack_.item.id].item_count += items_to_pack_
		return 0
	else:
		inventory_metadata_map[item_stack_.item.id].item_count \
				+= (item_stack_.item.max_stack_size - item_stack_.count)
		item_stack_.count = item_stack_.item.max_stack_size
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
	if inventory_metadata_map.has(item_stack_.item.id):
		var metadata: InventoryData._InventoryMetadata = \
				inventory_metadata_map[item_stack_.item.id]
		metadata.item_count += item_stack_.count
		metadata.index_map[index_] = true
	else:
		var new_metadata: InventoryData._InventoryMetadata = InventoryData._InventoryMetadata.new()
		new_metadata.item_count = item_stack_.count
		new_metadata.index_map[index_] = true
		inventory_metadata_map[item_stack_.item.id] = new_metadata

func _remove_item_stack(item_stack_: ItemStack) -> ItemStack: 
	var overflow: ItemStack = _remove_item_stack_single_pass(item_stack_)
	if overflow == null or overflow == item_stack_:
		return overflow
	return _remove_item_stack(overflow)

func _remove_item_stack_single_pass(item_stack_: ItemStack) -> ItemStack:
	if !inventory_metadata_map.has(item_stack_.item.id):
		return item_stack_
	var metadata: InventoryData._InventoryMetadata = \
			inventory_metadata_map[item_stack_.item.id]
	var index: int = metadata.index_map.keys()[metadata.index_map.size() - 1]
	if inventory_items[index].count >= item_stack_.count:
		inventory_items[index].count -= item_stack_.count
		metadata.item_count -= item_stack_.count
		if inventory_items[index].count == 0:
			inventory_items[index] = ItemStack.new()
			_move_index_to_null_stack(item_stack_, index)
		return null
	var result: ItemStack = ItemStack.new()
	result.item = item_stack_.item
	result.count = item_stack_.count - inventory_items[index].count
	metadata.item_count -= inventory_items[index].count
	inventory_items[index] = ItemStack.new()
	_move_index_to_null_stack(item_stack_, index)
	return result

func _move_index_to_null_stack(item_stack_: ItemStack, index_: int) -> void:
	var metadata: InventoryData._InventoryMetadata = \
			inventory_metadata_map[item_stack_.item.id]
	metadata.index_map.erase(index_)
	if metadata.index_map.is_empty():
		inventory_metadata_map.erase(item_stack_.item.id)
	var null_metadata: InventoryData._InventoryMetadata = inventory_metadata_map[-1]
	null_metadata.index_map[index_] = true

func serialize() -> Array:
	return inventory_items.map(func(x: ItemStack) -> Dictionary: return x.serialize())

func deserialize(data: Array) -> void:
	inventory_items.assign(data.map(func(x: Dictionary) -> ItemStack:
			var item_stack := ItemStack.new()
			item_stack.deserialize(x)
			return item_stack))
	_initialize_metadata_map()

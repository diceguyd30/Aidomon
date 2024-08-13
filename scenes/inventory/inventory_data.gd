class_name InventoryData
extends Resource

@export var max_inventory_size: int = 10
# Ordered inventory items as they should appear in the UI
@export var inventory_items: Array[ItemStack] = []
# Dictionary<ItemID: _InventoryMetadata>
@export var inventory_metadata_map: Dictionary = {}

class _InventoryMetadata:
	@export var item_count: int = 0
	# Dictionary<inventory_index: true>  Used as a Set
	@export var index_map: Dictionary

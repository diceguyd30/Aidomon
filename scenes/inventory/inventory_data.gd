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



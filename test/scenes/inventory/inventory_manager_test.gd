# GdUnit generated TestSuite
class_name InventoryDataTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://scenes/inventory/inventory_manager.gd'

var inventory_manager: InventoryManager

func before_test() -> void:
	self.inventory_manager = InventoryManager.load_with_inventory(null)

func test_add_item_stack() -> void:
	const WOOD = preload("res://resources/items/foragables/wood.tres")
	var item_stack: ItemStack = ItemStack.new()
	item_stack.item = WOOD
	item_stack.count = 10
	assert_result(self.inventory_manager.add_item_stack(item_stack)).is_null()
	
	assert_int(self.inventory_manager.inventory_data.inventory_items[0].count).is_equal(10)

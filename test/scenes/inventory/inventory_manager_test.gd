# GdUnit generated TestSuite
class_name InventoryDataTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://scenes/inventory/inventory_manager.gd'

var inventory_data: InventoryData
var get_inventory: Callable = func() -> InventoryData: return inventory_data
var inventory_manager: InventoryManager = InventoryManager.new().with_inventory(get_inventory)

func test_add_item_stack() -> void:
	inventory_data = InventoryManager.create_new_inventory_data()
	var item_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	assert_that(self.inventory_manager._add_item_stack(item_stack)).is_null()
	assert_that(self.inventory_manager.inventory.inventory_items[0].count) \
			.is_equal(InventoryHelpers.DEFAULT_STACK_COUNT)
	assert_that(self.inventory_manager.inventory.inventory_metadata_map[InventoryHelpers.DEFAULT_ID] \
			.index_map.keys().size()).is_equal(1)

func test_empty_list_updated_on_add() -> void:
	inventory_data = InventoryManager.create_new_inventory_data()
	var item_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	assert_that(self.inventory_manager._add_item_stack(item_stack)).is_null()
	assert_that(self.inventory_manager.inventory.inventory_metadata_map[null] \
			.index_map.keys().size()).is_equal(InventoryHelpers.DEFAULT_MAX_STACK_SIZE - 1)

func test_add_item_when_inventory_full() -> void:
	const INVENTORY_SIZE: int = 1
	inventory_data = InventoryManager.create_new_inventory_data(INVENTORY_SIZE)
	const TEST_ID_1: int = 1
	const TEST_ID_2: int = 2
	var item_stack_1: ItemStack = InventoryHelpers.build_test_item_stack(TEST_ID_1)
	var item_stack_2: ItemStack = InventoryHelpers.build_test_item_stack(TEST_ID_2)
	assert_that(self.inventory_manager._add_item_stack(item_stack_1)).is_null()
	assert_that(self.inventory_manager._add_item_stack(item_stack_2)).is_equal(item_stack_2)
	assert_that(self.inventory_manager.inventory.inventory_items[0].count) \
			.is_equal(InventoryHelpers.DEFAULT_STACK_COUNT)
	assert_that(self.inventory_manager.inventory.inventory_items[0].item.id) \
			.is_equal(TEST_ID_1)

func test_add_item_that_overflows_inventory() -> void:
	const INVENTORY_SIZE: int = 1
	inventory_data = InventoryManager.create_new_inventory_data(INVENTORY_SIZE)
	var item_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	item_stack.count = 15
	assert_that(self.inventory_manager._add_item_stack(item_stack).count).is_equal(5)

func test_add_greater_than_stack_size() -> void:
	inventory_data = InventoryManager.create_new_inventory_data()
	var item_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	item_stack.count = InventoryHelpers.DEFAULT_MAX_STACK_SIZE * 3
	assert_that(self.inventory_manager._add_item_stack(item_stack)).is_null()
	assert_that(self.inventory_manager.inventory.inventory_items[2].count) \
			.is_equal(InventoryHelpers.DEFAULT_MAX_STACK_SIZE)
	assert_that(self.inventory_manager.inventory.inventory_metadata_map[InventoryHelpers.DEFAULT_ID] \
			.index_map.keys().size()).is_equal(3)

func test_update_existing_item_stack() -> void:
	inventory_data = InventoryManager.create_new_inventory_data()
	var item_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	assert_that(self.inventory_manager._add_item_stack(item_stack)).is_null()
	assert_that(self.inventory_manager._add_item_stack(item_stack)).is_null()
	assert_that(self.inventory_manager.inventory.inventory_items[0].count) \
			.is_equal(InventoryHelpers.DEFAULT_STACK_COUNT * 2)

func test_update_item_stack_overflow() -> void:
	inventory_data = InventoryManager.create_new_inventory_data()
	var item_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	item_stack.item.max_stack_size = InventoryHelpers.DEFAULT_STACK_COUNT
	assert_that(self.inventory_manager._add_item_stack(item_stack)).is_null()
	assert_that(self.inventory_manager._add_item_stack(item_stack)).is_null()
	assert_that(self.inventory_manager.inventory.inventory_items[1].count) \
			.is_equal(InventoryHelpers.DEFAULT_STACK_COUNT)

func test_update_item_multiple_stack_overflow() -> void:
	inventory_data = InventoryManager.create_new_inventory_data()
	var item_stack_1: ItemStack = InventoryHelpers.build_test_item_stack()
	item_stack_1.count = InventoryHelpers.DEFAULT_MAX_STACK_SIZE
	assert_that(self.inventory_manager._add_item_stack(item_stack_1)).is_null()
	var item_stack_2: ItemStack = InventoryHelpers.build_test_item_stack()
	item_stack_2.count = InventoryHelpers.DEFAULT_MAX_STACK_SIZE * 2
	assert_that(self.inventory_manager._add_item_stack(item_stack_2)).is_null()
	assert_that(self.inventory_manager.inventory.inventory_items[2].count) \
			.is_equal(InventoryHelpers.DEFAULT_MAX_STACK_SIZE)
	assert_that(self.inventory_manager.inventory.inventory_metadata_map[item_stack_2.item.id] \
			.index_map.size()).is_equal(3)

func test_remove_item_exact_count_one_stack() -> void:
	inventory_data = InventoryManager.create_new_inventory_data()
	var item_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	item_stack.count = 5
	assert_that(self.inventory_manager._add_item_stack(item_stack)).is_null()
	assert_that(self.inventory_manager._remove_item_stack(item_stack)).is_null()
	assert_that(self.inventory_manager.inventory.inventory_metadata_map \
			.has(item_stack.item.id)).is_equal(false)
	assert_that(self.inventory_manager.inventory.inventory_metadata_map[null].index_map.has(0)).is_equal(true)

func test_remove_item_less_than_one_stack() -> void:
	inventory_data = InventoryManager.create_new_inventory_data()
	var item_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	item_stack.count = 5
	assert_that(self.inventory_manager._add_item_stack(item_stack)).is_null()
	var remove_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	remove_stack.count = 3
	assert_that(self.inventory_manager._remove_item_stack(remove_stack)).is_null()
	assert_that(self.inventory_manager.inventory.inventory_metadata_map \
			.has(item_stack.item.id)).is_equal(true)
	assert_that(self.inventory_manager.inventory.inventory_metadata_map[null].index_map.has(0)).is_equal(false)
	assert_that(self.inventory_manager.inventory.inventory_metadata_map[item_stack.item.id].item_count == 2)

func test_remove_item_more_than_one_stack() -> void:
	inventory_data = InventoryManager.create_new_inventory_data()
	var item_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	item_stack.count = 5
	assert_that(self.inventory_manager._add_item_stack(item_stack)).is_null()
	var remove_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	remove_stack.count = 7
	var result_stack: ItemStack = InventoryHelpers.build_test_item_stack()
	result_stack.count = 2
	assert_that(self.inventory_manager._remove_item_stack(remove_stack)).is_equal(result_stack)
	assert_that(self.inventory_manager.inventory.inventory_metadata_map \
			.has(item_stack.item.id)).is_equal(false)
	assert_that(self.inventory_manager.inventory.inventory_metadata_map[null].index_map.has(0)).is_equal(true)

class_name InventoryHelpers
extends Object

const DEFAULT_ID: int = 1
const DEFAULT_MAX_STACK_SIZE: int = 10
const DEFAULT_STACK_COUNT: int = 5
const DEFAULT_ITEM_NAME: String = "Test Item %d"

static func build_test_item_stack(
		id_: int = DEFAULT_ID, 
		max_stack_size_: int = DEFAULT_MAX_STACK_SIZE, 
		count_: int = DEFAULT_STACK_COUNT) -> ItemStack:
	var item_stack: ItemStack = ItemStack.new()
	var item: ItemData = ItemData.new()
	item.id = id_
	item.name = DEFAULT_ITEM_NAME % id_
	item.max_stack_size = max_stack_size_
	item_stack.item = item
	item_stack.count = count_
	return item_stack

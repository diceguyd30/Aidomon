class_name Inventory
extends Control

@onready var grid_container: GridContainer = %GridContainer
var inventory_manager: InventoryManager

func _ready() -> void:
	inventory_manager = InventoryManager.load_with_inventory(null)
	GameSignals.connect("reward_player", _add_bundle_to_inventory)
	_update_inventory()
	
func _add_bundle_to_inventory(reward: ItemBundle) -> void:
	inventory_manager.add_item_bundle(reward) # need to handle result
	_update_inventory()

func _update_inventory() -> void:
	for child in grid_container.get_children():
		grid_container.remove_child(child)
		child.queue_free()
	inventory_manager.inventory_data.inventory_items.map(
		func(x: ItemStack) -> void:
			var slot: ItemStackUI = ItemStackUI.create_with_data(x)
			grid_container.add_child(slot)
	)

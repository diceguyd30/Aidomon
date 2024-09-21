class_name Inventory
extends Control

@onready var grid_container: GridContainer = %GridContainer

const ITEM_STACK_UI = preload("res://scenes/common/item_stack_ui.tscn")
const UTIL = preload("res://scripts/util.gd")

func _ready() -> void:
	GameSignals.reward_player_signal.connect(_add_bundle_to_inventory)
	GameSignals.update_inventory_signal.connect(_update_inventory)
	_update_inventory()
	
func _add_bundle_to_inventory(reward: ItemBundle) -> void:
	Player.player_inventory.add_item_bundle(reward) # need to handle result

func _update_inventory() -> void:
	UTIL.clear_children(grid_container)
	Player.player_inventory.inventory_items.map(
		func(x: ItemStack) -> void:
			var slot: ItemStackUI = ITEM_STACK_UI.instantiate().with_data(x)
			grid_container.add_child(slot)
	)

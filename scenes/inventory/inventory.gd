class_name Inventory
extends Control

@onready var grid_container: GridContainer = %GridContainer

func _ready() -> void:
	GameSignals.connect("reward_player", _add_bundle_to_inventory)
	
func _add_bundle_to_inventory(reward: ItemBundle) -> void:
	reward.item_list.map(
		func(x: ItemStack) -> void: 
			var slot: InventorySlot = InventorySlot.create_with_data(x)
			grid_container.add_child(slot)
	)

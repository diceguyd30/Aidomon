class_name InventorySlot
extends Control

var item_stack: ItemStack

@onready var inventory_icon: TextureRect = %InventoryIcon
@onready var item_count_label: Label = %ItemCountLabel

const INVENTORY_SLOT: PackedScene = preload("res://scenes/inventory/inventory_slot.tscn")

static func create_with_data(item_stack_: ItemStack) -> InventorySlot:
	var slot: InventorySlot = INVENTORY_SLOT.instantiate()
	slot.item_stack = item_stack_
	return slot

func _ready() -> void:
	inventory_icon.texture = self.item_stack.item.icon
	var item_count: int = self.item_stack.count
	item_count_label.text = str(item_count) if item_count > 0 else ""

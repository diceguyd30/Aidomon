class_name ItemStackUI
extends Control

var item_stack: ItemStack

@onready var inventory_icon: TextureRect = %InventoryIcon
@onready var item_count_label: Label = %ItemCountLabel

const ITEM_STACK: PackedScene = preload("res://scenes/common/item_stack_ui.tscn")

static func create_with_data(item_stack_: ItemStack) -> ItemStackUI:
	var stack: ItemStackUI = ITEM_STACK.instantiate()
	stack.item_stack = item_stack_
	return stack

func _ready() -> void:
	if item_stack.item != null:
		inventory_icon.texture = self.item_stack.item.icon
		var item_count: int = self.item_stack.count
		item_count_label.text = str(item_count) if item_count > 0 else ""

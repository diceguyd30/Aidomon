class_name ItemStackUI
extends Control

@export var item_stack: ItemStack:
	set(value):
		item_stack = value
		_update()

@onready var inventory_icon: TextureRect = %InventoryIcon
@onready var item_count_label: Label = %ItemCountLabel

func _ready() -> void:
	_update()
	
func _update() -> void:
	if self.item_stack.item == null:
		return
	if inventory_icon != null:
		inventory_icon.texture = self.item_stack.item.icon
	if item_count_label != null:
		var item_count: int = self.item_stack.count
		item_count_label.text = str(item_count) if item_count > 0 else ""

class_name ItemStackUI
extends Control

@export var item_stack: ItemStack:
	set(value):
		item_stack = value
		_update()

@onready var inventory_icon: TextureRect = %InventoryIcon
@onready var item_count_label: Label = %ItemCountLabel

var _inventory_tracking: bool = false

func with_data(item_stack_: ItemStack) -> ItemStackUI:
	self.item_stack = item_stack_
	return self
	
func with_inventory_tracking() -> ItemStackUI:
	GameSignals.update_inventory_signal.connect(_update_color)
	self._inventory_tracking = true
	return self

func _ready() -> void:
	_update()
	if _inventory_tracking:
		_update_color()
	
func _update() -> void:
	if self.item_stack.item == null:
		return
	if inventory_icon != null:
		inventory_icon.texture = self.item_stack.item.icon
	if item_count_label != null:
		var item_count: int = self.item_stack.count
		item_count_label.text = str(item_count) if item_count > 0 else ""

func _update_color() -> void:
	if item_count_label == null or item_stack.item == null:
		return
	if Player.player_inventory.has_enough(item_stack):
		item_count_label.label_settings.font_color = Color(0, 1.0, 0, 1.0)
		return
	item_count_label.label_settings.font_color = Color(1.0, 0, 0, 1.0)

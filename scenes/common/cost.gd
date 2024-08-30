class_name Cost
extends Control

@export var unlock: Unlock:
	set(value):
		unlock = value
		_update()

@onready var title: Label = %Title
@onready var description: Label = %Description
@onready var cost_grid: GridContainer = %CostGrid
@onready var unlock_btn: Button = %UnlockBtn

const ITEM_STACK_UI = preload("res://scenes/common/item_stack_ui.tscn")

func _ready() -> void:
	_update()

func _update() -> void:
	if title == null or description == null or cost_grid == null:
		return
	title.text = unlock.name
	description.text = unlock.description
	for item: ItemStack in unlock.cost.item_list:
		cost_grid.add_child(ITEM_STACK_UI.instantiate().with_data(item).with_inventory_tracking())

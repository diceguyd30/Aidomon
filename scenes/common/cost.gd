@tool
class_name Cost
extends Control

signal purchased(unlock: Unlock)

@export var unlock: Unlock

@onready var title: Label = %Title
@onready var description: Label = %Description
@onready var cost_grid: GridContainer = %CostGrid
@onready var unlock_btn: Button = %UnlockBtn

const ITEM_STACK_UI = preload("res://scenes/common/item_stack_ui.tscn")

func with_data(unlock_: Unlock) -> Cost:
	unlock = unlock_
	return self

func _ready() -> void:
	if !Engine.is_editor_hint():
		GameSignals.update_inventory_signal.connect(_update_enabled)
	_update_enabled()
	title.text = unlock.name
	description.text = unlock.description
	for item: ItemStack in unlock.cost.item_list:
		cost_grid.add_child(ITEM_STACK_UI.instantiate().with_data(item).with_inventory_tracking())

func _on_unlock_btn_pressed() -> void:
	purchased.emit(unlock)

func _update_enabled() -> void:
	unlock_btn.disabled = Engine.is_editor_hint() or !Player.player_inventory.has_all(unlock.cost)

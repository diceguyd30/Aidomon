class_name CraftingMenuItem
extends Control

@export var recipe: Recipe:
	set(value):
		recipe = value
		_update()

@onready var reward_list: HBoxContainer = %RewardList
@onready var item_name: Label = %ItemName
@onready var cost_grid: GridContainer = %CostGrid
@onready var craft_button: Button = %CraftButton

const BIG_ITEM_STACK_UI = preload("res://scenes/common/big_item_stack_ui.tscn")
const ITEM_STACK_UI = preload("res://scenes/common/item_stack_ui.tscn")

func _ready() -> void:
	GameSignals.update_inventory_signal.connect(_update_enabled)
	_update()
	_update_enabled()
	
func _update() -> void:
	if recipe == null:
		return
	
	if reward_list != null:
		for item: ItemStack in recipe.reward.item_list:
			reward_list.add_child(BIG_ITEM_STACK_UI.instantiate().with_data(item))
	if item_name != null:
		item_name.text = recipe.name
	if cost_grid != null:
		for item: ItemStack in recipe.cost.item_list:
			cost_grid.add_child(ITEM_STACK_UI.instantiate().with_data(item).with_inventory_tracking())

func _on_button_pressed() -> void:
	Player.player_inventory.remove_item_bundle(recipe.cost)
	GameSignals.reward_player(recipe.reward)

func _update_enabled() -> void:
	craft_button.disabled = !Player.player_inventory.has_all(recipe.cost)

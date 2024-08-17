class_name CraftingMenuItem
extends Control

@export var recipe: Recipe:
	set(value):
		recipe = value
		_update()

@onready var reward_list: HBoxContainer = %RewardList
@onready var item_name: Label = %ItemName
@onready var cost_grid: GridContainer = %CostGrid

const BIG_ITEM_STACK_UI = preload("res://scenes/common/big_item_stack_ui.tscn")
const ITEM_STACK_UI = preload("res://scenes/common/item_stack_ui.tscn")

func _ready() -> void:
	_update()
	
func _update() -> void:
	if recipe == null:
		return
	
	if reward_list != null:
		for item: ItemStack in recipe.reward.item_list:
			var reward_stack: ItemStackUI = BIG_ITEM_STACK_UI.instantiate().with_data(item)
			reward_list.add_child(reward_stack)
	if item_name != null:
		item_name.text = recipe.name
	if cost_grid != null:
		for item: ItemStack in recipe.cost.item_list:
			var cost_stack: ItemStackUI = ITEM_STACK_UI.instantiate().with_data(item)
			cost_grid.add_child(cost_stack)

func _on_button_pressed() -> void:
	GameSignals.reward_player(recipe.reward)

class_name CraftingMenuItem
extends Control

@export var recipe: Recipe

@onready var reward_list: HBoxContainer = %RewardList
@onready var item_name: Label = %ItemName
@onready var cost_grid: GridContainer = %CostGrid

const BIG_ITEM_STACK_UI = preload("res://scenes/common/big_item_stack_ui.tscn")
const ITEM_STACK_UI = preload("res://scenes/common/item_stack_ui.tscn")

func _ready() -> void:
	if recipe != null:
		for item: ItemStack in recipe.reward.item_list:
			var reward_stack: ItemStackUI = BIG_ITEM_STACK_UI.instantiate()
			reward_stack.item_stack = item
			reward_list.add_child(reward_stack)
		item_name.text = recipe.name
		for item: ItemStack in recipe.cost.item_list:
			var cost_stack: ItemStackUI = ITEM_STACK_UI.instantiate()
			cost_stack.item_stack = item
			cost_grid.add_child(cost_stack)

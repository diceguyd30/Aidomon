class_name ItemCost
extends Control

var item_stack: ItemStack

@onready var icon: TextureRect = %Icon
@onready var cost_lbl: Label = %CostLbl

const ITEM_COST: PackedScene = preload("res://scenes/craftbench/item_cost.tscn")

static func create_with_data(item_stack_: ItemStack) -> ItemCost:
	var cost: ItemCost = ITEM_COST.instantiate()
	cost.item_stack = item_stack_
	return cost

func _ready() -> void:
	if item_stack.item != null:
		icon.texture = self.item_stack.item.icon
		var item_count: int = self.item_stack.count
		cost_lbl.text = str(item_count) if item_count > 0 else ""

class_name CraftingMenuItem
extends Control

@export var recipe: Recipe

@onready var icon: TextureRect = %Icon
@onready var item_name: Label = %ItemName

const CRAFTING_MENU_ITEM: PackedScene = preload("res://scenes/craftbench/crafting_menu_item.tscn")

static func create_with_data(recipe_: Recipe) -> CraftingMenuItem:
	var crafting_menu_item: CraftingMenuItem = CRAFTING_MENU_ITEM.instantiate()
	crafting_menu_item.recipe = recipe_
	return crafting_menu_item

func _ready() -> void:
	if recipe.item != null:
		pass

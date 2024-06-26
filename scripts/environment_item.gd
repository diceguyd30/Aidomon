class_name EnvironmentItem
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
const ENVIRONMENT_ITEM: PackedScene = preload("res://scenes/environment_item.tscn")

var environment_item_data: EnvironmentItemData

func _ready():
	sprite_2d.texture = environment_item_data.icon
		
static func create_with_data(environment_item_data_: EnvironmentItemData) -> EnvironmentItem:
	var item: EnvironmentItem = ENVIRONMENT_ITEM.instantiate()
	item.environment_item_data = environment_item_data_
	return item

class_name EnvironmentItem
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
const ENVIRONMENT_ITEM: PackedScene = preload("res://scenes/wilderness/environment_item.tscn")

var environment_item_data: EnvironmentItemData

static func create_with_data(environment_item_data_: EnvironmentItemData) -> EnvironmentItem:
	var item: EnvironmentItem = ENVIRONMENT_ITEM.instantiate()
	item.environment_item_data = environment_item_data_
	return item

func _ready() -> void:
	sprite_2d.texture = environment_item_data.icon

func _on_sprite_clicked() -> void:
	GameSignals.emit_signal("reward_player", environment_item_data.reward)
	environment_item_data.reward.item_list.map(
		func(x: ItemStack) -> void: 
			print("Rewarding player with %d %s" % [x.count, x.item.name]))
	queue_free()

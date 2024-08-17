class_name EnvironmentItem
extends Node2D

@export var environment_item_data: EnvironmentItemData:
	set(value):
		environment_item_data = value
		_update()

@onready var sprite_2d: Sprite2D = $Sprite2D

func with_data(environment_item_data_: EnvironmentItemData) -> EnvironmentItem:
	self.environment_item_data = environment_item_data_
	return self

func _ready() -> void:
	_update()

func _update() -> void:
	if environment_item_data != null and sprite_2d != null:
		sprite_2d.texture = environment_item_data.icon

func _on_sprite_clicked() -> void:
	GameSignals.reward_player.emit(environment_item_data.reward)
	environment_item_data.reward.item_list.map(
		func(x: ItemStack) -> void: 
			print("Rewarding player with %d %s" % [x.count, x.item.name]))
	queue_free()

@tool
class_name CreatureInvUi
extends Control

@export var creature: Creature:
	set(value):
		creature = value
		_update()

@onready var inventory_icon: TextureRect = %InventoryIcon

func with_data(creature_: Creature) -> CreatureInvUi:
	self.creature = creature_
	return self

func _ready() -> void:
	_update()

func _update() -> void:
	if inventory_icon == null:
		return
	inventory_icon.texture = creature.icon if creature != null else null

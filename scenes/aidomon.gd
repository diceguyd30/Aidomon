extends Control

@onready var inventory: Inventory = %Inventory

func _ready() -> void:
	inventory.inventory = Player.player_inventory

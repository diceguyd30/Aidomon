extends Control

@onready var inventory: Inventory = %Inventory
@onready var collection: Collection = %Collection

func _ready() -> void:
	inventory.inventory = Player.player_inventory

func _on_inventory_btn_pressed() -> void:
	collection.visible = false
	inventory.visible = true

func _on_aidomon_btn_pressed() -> void:
	collection.visible = true
	inventory.visible = false

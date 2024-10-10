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

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("fullscreen") and event.is_action("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

@tool
class_name TownLocation
extends Control

signal toggled(toggled_on: bool)

@export var unlock: Unlock
@export var texture: Texture
@export var hover_texture: Texture
@export var selected_texture: Texture

@onready var location_container: VBoxContainer = %LocationContainer
@onready var location_btn: TextureButton = %LocationBtn
@onready var location_lbl: Label = %LocationLbl
@onready var cost_container: CenterContainer = %CostContainer

const COST = preload("res://scenes/common/cost.tscn")

func _ready() -> void:
	location_lbl.text = unlock.name
	var cost: Cost = COST.instantiate().with_data(unlock)
	cost.purchased.connect(_location_unlocked)
	cost_container.add_child(cost)
	location_btn.texture_normal = texture
	location_btn.texture_hover = hover_texture
	location_btn.texture_pressed = selected_texture
	_update_visibility()

func _update_visibility() -> void:
	if Engine.is_editor_hint():
		location_container.visible = true
		cost_container.visible = false
		return
	var unlocked: bool = Player.biome_unlocks.unlock_map[unlock.id]
	location_container.visible = unlocked
	cost_container.visible = !unlocked

func _location_unlocked(unlock_: Unlock) -> void:
	Player.player_inventory.remove_item_bundle(unlock_.cost)
	Player.biome_unlocks.unlock(unlock_)
	_update_visibility()

func _on_location_btn_mouse_entered() -> void:
	location_lbl.modulate.a = 1.0

func _on_location_btn_mouse_exited() -> void:
	location_lbl.modulate.a = 0.7

func _on_location_btn_toggled(toggled_on: bool) -> void:
	toggled.emit(toggled_on)

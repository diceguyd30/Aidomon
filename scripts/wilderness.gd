class_name Wilderness
extends Node2D

var biome_data: Biome = preload("res://resources/biomes/starting.tres")
@onready var background: TextureRect = $Background
@onready var timer: Timer = $Timer

var off_screen_distance: int = 100
var edge_buffer: int = 10

func _ready() -> void:
	background.texture = biome_data.background

func _on_timer_timeout() -> void:
	var item: EnvironmentItem = EnvironmentItem.create_with_data(_get_environment_item())
	item.position = _get_spawnpoint()
	background.add_child(item)
	timer.wait_time = randi_range(8, 20)

func _get_environment_item() -> EnvironmentItemData:
	return biome_data.environment_items.pick_random()

func _get_spawnpoint() -> Vector2:
	var x: int = randi_range(0 + edge_buffer, int(background.size.x) - edge_buffer)
	var y: int = randi_range(0 + edge_buffer, int(background.size.y) - edge_buffer)
	return Vector2(x, y)

class_name Wilderness
extends Node2D

var biome_data: Biome
@onready var background = $Background
@onready var timer = $Timer

var off_screen_distance: int = 100
var edge_buffer: int = 10

func _init(biome_data_: Biome = preload("res://resources/biomes/starting.tres")):
	self.biome_data = biome_data_

func _ready():
	background.texture = biome_data.background

func _on_timer_timeout():
	var item = EnvironmentItem.create_with_data(get_environment_item())
	item.position = get_spawnpoint()
	background.add_child(item)
	timer.wait_time = randi_range(8, 20)

func get_environment_item() -> EnvironmentItemData:
	return biome_data.environment_items.pick_random()

func get_spawnpoint() -> Vector2:
	var x = randi_range(0 + 50, background.size.x - 50)
	var y = randi_range(0 + 50, background.size.y - 50)
	return Vector2(x, y)

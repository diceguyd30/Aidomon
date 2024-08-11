class_name Wilderness
extends Control

var wilderness_data: WildernessData = preload("res://resources/wilderness/starting.tres")
@onready var background: TextureRect = %Background
@onready var timer: Timer = $Timer

var off_screen_distance: int = 100
var edge_buffer: int = 10

func _ready() -> void:
	background.texture = wilderness_data.background

func _on_timer_timeout() -> void:
	var item: EnvironmentItem = EnvironmentItem.create_with_data(_get_environment_item())
	item.position = _get_spawnpoint()
	background.add_child(item)
	timer.wait_time = randi_range(5, 10)

func _get_environment_item() -> EnvironmentItemData:
	return wilderness_data.environment_items.pick_random()

func _get_spawnpoint() -> Vector2:
	var x: int = randi_range(0 + edge_buffer, int(background.size.x) - edge_buffer)
	var y: int = randi_range(0 + edge_buffer, int(background.size.y) - edge_buffer)
	return Vector2(x, y)

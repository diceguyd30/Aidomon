class_name TerrainGenerator
extends Node

const CHARACTER = preload("res://scenes/character.tscn")
@onready var timer = $Timer
@onready var background = %Background

var off_screen_distance = 100

func _on_timer_timeout():
	var character = CHARACTER.instantiate()
	character.position = get_offscreen_spawnpoint()
	background.add_child(character)
	timer.wait_time = randi_range(8, 20)

func get_offscreen_spawnpoint() -> Vector2:
	var x = background.size.x + off_screen_distance
	var y = randi_range(0 + 50, background.size.y - 50)
	return Vector2(x, y)

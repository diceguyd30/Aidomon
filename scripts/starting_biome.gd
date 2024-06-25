extends Node2D

const BIOME_DATA = preload("res://resources/biomes/starting.tres")
@onready var background = $Background

func _ready():
	background.texture = BIOME_DATA.background


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends Node2D

var biome_data: Biome
@onready var background = $Background
@onready var timer = $Timer

func _init(biome_data_: Biome = preload("res://resources/biomes/starting.tres")):
	self.biome_data = biome_data_

func _ready():
	background.texture = biome_data.background
